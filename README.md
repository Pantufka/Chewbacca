# Obligatorio Implementación de Soluciones Cloud

Se presenta el diseño de la mejora para la actual infraestructura cumpliendo los objetivos brindados en la consigna para la materia Implementación de Soluciones Cloud.

## Contenido

En el directorio raíz se encuentran todos los archivos Terraform además de la carpeta con los módulos necesarios para poder cumplir con el despliegue de la infraestructura y la carpeta que contiene todos los archivos de la aplicación a desplegar.

## Requisitos generales

Para poder clonar y correr el repositorio en el ordenador correctamente, primero es necesario instalar varios paquetes, siendo Git el primero de ellos. Su instalación se hace con el comando:

```bash
$ sudo dnf install -y git
```
Una vez instalado, se puede verificar su versión con el comando:

```bash
$ git --version
```
El segundo paquete que se necesita instalar es Terraform con el comando:

```bash
$ sudo dnf install -y terraform
```
Como con el paquete anterior, se puede verificar su versión con el comando:

```bash
$ terraform -version
```
Para instalar el último paquete, que es AWS, necesitamos primero verificar que unzip esté instalado con el comando:

```bash
$ unzip --version
```
En caso de que el resultado sea unzip: command not found, eso significa que unzip no está instalado. Se puede instalar con el comando:

```bash
$ sudo dnf install -y unzip
```
Ahora si, verificamos que esté correctamente instalado con el comando:

```bash
$ unzip --version
```
Una vez confirmado lo de unzip, se necesita instalar AWS con el comando: 

```bash
$ curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
```
Luego se descomprime el paquete con el comando:

```bash
$ unzip awscliv2.zip
```
Una vez descomprimido, se ejecuta el insalador con el comando:

```bash
$ sudo ./aws/install
```
Como con el resto de paquetes, verificamos con el comando:

```bash
$ aws --version
```
Con AWS ya instalado, se puede configurar las keys de AWS en ~/.aws/credentials para poder acceder sin problemas. De otra forma puede configurarlo utilizando:

```bash
$ aws configure
```
Ahora si, luego de tener los tres paquetes instalados, se puede clonar el repositorio con el comando:

```bash
$ git clone https://github.com/Pantufka/Chewbacca.git
```
Y , para acceder al repositorio recientemente clonado, se utiliza el comando:

```bash
$ cd Chewbacca
```

## Modo de uso

Antes de hacer el deployment de la infraestructura por Terraform, se debe inicializar el proyecto de Terraform con el comando:

```bash
$ terraform init
```
Para verificar que toda la infraestructura propuesta está correcta, se corre el comando:

```bash
$ terraform validate
```
El resultado del comando anterior debería ser "Success! The configuration is valid.". Una vez verificada la infraestructura, se calcula qué cambios realizará Terraform con el comando:

```bash
$ terraform plan
```
Por último, Terraform creará los recursos necesarios para que la infraestructura quede igual a la definida en el código con el comando:

```bash
$ terraform apply
```
Es un proceso que va a llevar unos cuantos minutos debido a la cantidad de recursos que se están creando, siendo la que más demore la base de datos. Terminado el proceso, se recibirá un mensaje que va a decir "Resources: 29 added, 0 changed, 0 destroyed."

## License

[MIT](https://choosealicense.com/licenses/mit/)
