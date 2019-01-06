#!/bin/bash
COMMAND=$1

export TF_VAR_region=${REGION}
export TF_VAR_stack_version=${STACK_VERSION}
export TF_VAR_webapp_appname=${APP_NAME}
export TF_VAR_live_alb_cname=${LIVE_ALB_DNSNAME}


     echo "****** backend configuration options ************"
     echo "bucket=tf-developer"
     echo "key=${COMPONENT}/${APP_NAME}/${REGION}/${ENVIRONMENT}/${STACK_VERSION}.tfstate"
     echo "profile=devaccount"
     echo "${REGION}"
     terraform init \
     -backend-config="bucket=tf-developer" \
     -backend-config="key=${COMPONENT}/${APP_NAME}/${REGION}/${ENVIRONMENT}/${STACK_VERSION}.tfstate" \
     -backend-config="region=${REGION}" \
     -backend-config="profile=devaccount" \
     -backend-config="encrypt=true" \
     -backend-config="kms_key_id=arn:aws:kms:us-east-1:633215889360:key/f3db0336-2252-445c-aa21-d1d1edb75963"

if [ "${COMMAND}" = 'plan' ];
 then
   terraform get -update
   terraform ${COMMAND} -input=false
else
terraform get -update
terraform ${COMMAND} -auto-approve

fi;
