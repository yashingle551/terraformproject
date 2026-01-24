# 1. Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = var.VPC
  tags = {
    Name = "Yash-vpc"
  }
}

# 2. Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.Public-CICR
  availability_zone       = "eu-north-1a" # Change AZ if using a different region
  map_public_ip_on_launch = true # Automatically assign public IPs to instances
  tags = {
    Name = "public-subnet"
  }
}

# 3. Create Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.Private-CICR
  availability_zone = "eu-north-1b" # Change AZ if using a different region
  tags = {
    Name = "private-subnet"
  }
}

# 4. Create an Internet Gateway (IGW)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# 5. Create a Public Route Table and add a route to the IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" # Direct all internet traffic
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# 6. Associate the Public Route Table with the Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# 7. Create a Security Group (SG) allowing SSH (22) and HTTP (80)
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web traffic (SSH/HTTP) inbound"
  vpc_id      = aws_vpc.main.id

  # Inbound rule for SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound rule for HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule allowing all traffic
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # allows all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

# 8. Launch an EC2 instance in the public subnet
resource "aws_instance" "web_server" {
  ami           = var.IAM # Example AMI for Amazon Linux 2 in us-east-1
  instance_type = var.Launch-type
  subnet_id     = aws_subnet.public.id
  security_groups = [aws_security_group.allow_web.id]
  key_name      = var.SSHPem # !! REPLACE THIS WITH YOUR KEY NAME !!

  # Optional: User data to install a web server on launch
  user_data = file("install.sh")

  tags = {
    Name = "web-Yash"
  }
}
