# 250922-AWS-ADD-Eric
# Requerimientos de Diseño para la Infraestructura AWS

1. **Plantilla CloudFormation**
	- El archivo de infraestructura debe llamarse `infra.yml`.
	- La plantilla debe ser clara, modular y seguir buenas prácticas de nomenclatura y organización de recursos.

2. **Red (VPC)**
	- Utilizar la VPC por defecto de la cuenta, con el ID: `vpc-086fe118b4ed5c6e4`.
	- Todos los recursos deben estar asociados explícitamente a esta VPC.

3. **Instancia EC2**
	- Crear una instancia EC2 de tipo `t3.micro` (o el tipo T3 más adecuado según necesidades).
	- Etiquetar la instancia con el nombre `econtreras`.
	- Usar la imagen más reciente de Amazon Linux 2023, seleccionada dinámicamente según la región.
	- La instancia debe estar en una subred pública de la VPC por defecto.

4. **Seguridad**
	- No utilizar pares de claves SSH para acceso.
	- Crear un rol IAM específico para la instancia, con permisos mínimos necesarios (principio de menor privilegio).
	- Asociar el rol IAM creado a la instancia EC2.
	- Asociar el grupo de seguridad por defecto de la VPC a la instancia EC2.
	- Limitar el acceso entrante solo a los puertos y direcciones IP estrictamente necesarios.

5. **Buenas Prácticas**
	- Definir salidas (`Outputs`) relevantes en la plantilla, como el ID de la instancia, IP pública, etc.
	- Documentar cada recurso con comentarios en la plantilla.
	- Validar la plantilla con herramientas como `cfn-lint` antes de su despliegue..

## Despliegue con AWS CLI

Además de usar la consola de AWS, esta infraestructura puede desplegarse mediante **AWS CLI** con el siguiente comando:

```bash
aws cloudformation create-stack \
  --stack-name econtreras-654654327431 \
  --template-body file://infra.yml \
  --capabilities CAPABILITY_IAM \
  --region us-east-1 \
  --profile default \
  --output json \
  --parameters \
    ParameterKey=VpcId,ParameterValue=vpc-086fe118b4ed5c6e4 \
    ParameterKey=SubnetId,ParameterValue=subnet-0f86fb485374f9f0a \
    ParameterKey=InstanceType,ParameterValue=t3.micro \
    ParameterKey=SecurityGroupId,ParameterValue=sg-04f4c192bcfcf3f2b

## Notas sobre nombres en CloudFormation

- **Nombre del stack**:  
  El nombre definido en `--stack-name` **no se puede cambiar** una vez creado el stack.  
  Si necesitas corregirlo, debes ejecutar un `delete-stack` para eliminarlo y luego un `create-stack` con el nombre correcto.

- **Nombre de la instancia (tag Name)**:  
  El nombre que recibe la instancia EC2 (ej. `econtreras`) sí se puede cambiar mediante un `update-stack`, modificando el valor del parámetro `InstanceName`.  

Ejemplo de actualización solo del nombre de la instancia:

```bash
aws cloudformation update-stack \
  --stack-name econtreras-654654327431 \
  --template-body file://infra.yml \
  --capabilities CAPABILITY_IAM \
  --region us-east-1 \
  --profile default \
  --parameters \
    ParameterKey=VpcId,ParameterValue=vpc-086fe118b4ed5c6e4 \
    ParameterKey=SubnetId,ParameterValue=subnet-0f86fb485374f9f0a \
    ParameterKey=InstanceType,ParameterValue=t3.micro \
    ParameterKey=InstanceName,ParameterValue=nuevo-nombre \
    ParameterKey=SecurityGroupId,ParameterValue=sg-04f4c192bcfcf3f2b