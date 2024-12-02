# Security group for RDS to allow accessing the RDS through the specified port.
resource "aws_security_group" "rds_sg" {
    name = "${var.rds_cluster_name}-sg"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 3306 
        to_port = 3306 
        protocol = "tcp"
        self = true  // this allpws instances associated with this security group to access the RDS
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow to send TCP traffic on port 3306 to any ip address
    egress {
        from_port = 0 
        to_port = 0
        protocol = "-1" // all protocols
        self = true 
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.rds_cluster_name}-sg"
    }
}