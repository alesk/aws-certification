## AWS Fundamentals ALB + ASG + EBS

- (ALB) Load Balancing
- (ASG) Auto SCaling Group
- (EBS) Elasitc Block Store

To import existing resources, I used the following commands

```bash
export AWS_PROFILE=serverless
terraform import aws_autoscaling_group.apache apache
terraform import aws_launch_configuration.apache apache2Copy
terraform import  aws_lb.apache arn:aws:elasticloadbalancing:eu-west-1:305529814646:loadbalancer/app/my-first-alb/670c341f1b8c0ebe
```

## Resources

https://blog.valouille.fr/post/2018-03-22-how-to-use-terraform-to-deploy-an-alb-application-load-balancer-with-multiple-ssl-certificates/

Most important

https://techbloc.net/archives/3195


[1]: https://medium.com/cognitoiq/terraform-and-aws-application-load-balancers-62a6f8592bcf
[2]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/16
[3]: https://davidwzhang.com/2017/04/04/use-terraform-to-set-up-aws-auto-scaling-group-with-elb/

https://blog.valouille.fr/post/2018-03-27-how-to-use-keepass-xc-with-ssh-agent/
