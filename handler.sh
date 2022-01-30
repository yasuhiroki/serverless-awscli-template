function hello () {
  EVENT_DATA=$1
  echo "$EVENT_DATA" 1>&2;
  RESPONSE="{\"body\": {\"input\": $EVENT_DATA, \"msg\": \"$(/opt/awscli/aws --version)\"}}"

  echo $RESPONSE
}
