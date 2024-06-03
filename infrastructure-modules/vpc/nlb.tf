resource "aws_lb" "this" {
  name               = "traefik-${var.env}-external-lb" #var.nlb_name 
  internal           = true
  load_balancer_type = "network"
  subnets            = aws_subnet.private[*].id
  enable_deletion_protection = false
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "${var.env}-traefik-external-lb"
#   }
  
}

resource "aws_lb_target_group" "this" {
  name     = "traefik-${var.env}-tg"
  port     = 30761 #var.target_port
  protocol = "TCP"
  vpc_id   = aws_vpc.this.id
  target_type                       = "instance"
  preserve_client_ip                = "true"
  connection_termination            = false
  deregistration_delay              = "300"
  ip_address_type                   = "ipv4"

    health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200-399"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 6
    unhealthy_threshold = 2
    }

    stickiness {
    cookie_duration = 0
    enabled         = false
    type            = "source_ip"
    }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80 #var.listener_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

