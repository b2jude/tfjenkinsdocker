#!/bin/bash
COMMAND=$1
echo "You are deploying ${COMPONENT} \n"
echo "Your COMMAND is: ${COMMAND}"

export TF_VAR_region=${REGION}
export TF_VAR_appname=${APP_NAME}
export TF_VAR_stack_version=${STACK_VERSION}

     echo "****** backend configuration options ************"


     echo "bucket=tf-developer"
     echo "key=${APP_NAME}/${COMPONENT}/${REGION}/${ENVIRONMENT}/${STACK_VERSION}.tfstate"
     echo "profile=development"
     echo " REGION: ${REGION}"
     echo "APP_NAME: ${APP_NAME}"
     echo "COMPONENT: ${COMPONENT}"
     echo "ENVIRONMENT: ${ENVIRONMENT}"
     echo "STACK_VERSION: ${STACK_VERSION}"
     echo "`pwd`"
     rm -Rf ./.terraform
     echo "`pwd`"

     which terraform

     terraform init \
     -backend-config="bucket=tf-devbucket" \
     -backend-config="key=${APP_NAME}/${COMPONENT}/${REGION}/${ENVIRONMENT}/${STACK_VERSION}.tfstate" \
     -backend-config="region=${REGION}" \
     -backend-config="role_arn=arn:aws:iam::151679033716:role/Development-tf-jenkins-ec2-role" \
     -backend-config="encrypt=true" \
     -backend-config="kms_key_id=arn:aws:kms:us-east-1:151679033716:key/7d5edcb1-7f1a-4cb4-9904-3405416d664b" \
     -backend-config="session_name=tfstate"
    echo "backend created"


#/usr/local/bin/terraform init
#terraform init

if [ "${COMMAND}" = 'plan' ];
 then
   #/usr/local/bin/terraform ${COMMAND} -input=false
   terraform ${COMMAND} -input=false
else
#/usr/local/bin/terraform ${COMMAND} -auto-approve
terraform ${COMMAND} -auto-approve
#/usr/local/bin/terraform $apply -auto-approve
#/usr/local/bin/terraform destroy -auto-approve
fi;
