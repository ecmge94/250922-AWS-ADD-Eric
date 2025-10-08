#!/bin/bash

# Variables
STACK_NAME="econtreras-654654327431"
TEMPLATE_FILE="infra.yml"
REGION="us-east-1"
PROFILE="default"
LATEST_AMI_ID="ami-0ef2ca1adadcf9df7"
VPC_ID="vpc-086fe118b4ed5c6e4"
SUBNET_ID="subnet-0f86fb485374f9f0a"
INSTANCE_TYPE="t3.micro"
INSTANCE_NAME="econtreras"
SECURITY_GROUP_ID="sg-04f4c192bcfcf3f2b"
LAUNCH_TEMPLATE_NAME="lt-econtreras"
AUTOSCALING_GROUP_NAME="asg-econtreras"
SUBNET1="subnet-0f86fb485374f9f0a"
SUBNET2="subnet-0323a098b70caa778"
TAG_NAME="WebServer-Econtreras"
MIN_SIZE="2"
MAX_SIZE="4"
DESIRED_CAPACITY="2"

# Permitir sobreescribir los valores por argumentos de entorno
MIN_SIZE="${MIN_SIZE:-1}"
MAX_SIZE="${MAX_SIZE:-1}"
DESIRED_CAPACITY="${DESIRED_CAPACITY:-1}"

# Crear el stack de CloudFormation
aws cloudformation create-stack \
  --stack-name "$STACK_NAME" \
  --template-body file://"$TEMPLATE_FILE" \
  --capabilities CAPABILITY_IAM \
  --region "$REGION" \
  --profile "$PROFILE" \
  --parameters \
    ParameterKey=LatestAmiId,ParameterValue="$LATEST_AMI_ID" \
    ParameterKey=VpcId,ParameterValue="$VPC_ID" \
    ParameterKey=SubnetId,ParameterValue="$SUBNET_ID" \
    ParameterKey=InstanceType,ParameterValue="$INSTANCE_TYPE" \
    ParameterKey=InstanceName,ParameterValue="$INSTANCE_NAME" \
    ParameterKey=SecurityGroupId,ParameterValue="$SECURITY_GROUP_ID" \
    ParameterKey=LaunchTemplateName,ParameterValue="$LAUNCH_TEMPLATE_NAME" \
    ParameterKey=AutoScalingGroupName,ParameterValue="$AUTOSCALING_GROUP_NAME" \
    ParameterKey=Subnet1,ParameterValue="$SUBNET1" \
    ParameterKey=Subnet2,ParameterValue="$SUBNET2" \
    ParameterKey=TagName,ParameterValue="$TAG_NAME" \
    ParameterKey=MinSize,ParameterValue="$MIN_SIZE" \
    ParameterKey=MaxSize,ParameterValue="$MAX_SIZE" \
    ParameterKey=DesiredCapacity,ParameterValue="$DESIRED_CAPACITY"

echo "Stack $STACK_NAME creado exitosamente (proceso iniciado)."