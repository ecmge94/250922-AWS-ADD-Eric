#!/bin/bash

# Nombre del stack a eliminar
STACK_NAME="econtreras-654654327431"

# Comando para eliminar el stack
aws cloudformation delete-stack \
  --stack-name $STACK_NAME \
  --region us-east-1 \
  --profile default

echo "Eliminando el stack: $STACK_NAME"