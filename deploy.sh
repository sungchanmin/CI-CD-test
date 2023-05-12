!/usr/bin/env bash

REPOSITORY=/home/ubuntu/applications/ExampleAwsCodeDeploy
APP_NAME=BeginVeganBackend

echo "> 현재 구동중인 애플리케이션 pid 확인"
CURRENT_PID=$(pgrep -f $APP_NAME)
echo "$CURRENT_PID"

if [ -z $CURRENT_PID ]
then
  echo "> 실행중인 해당 애플리케이션이 없습니다. "
else
  echo "> kill -9 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> 새 어플리케이션 배포"

JAR_NAME=$(ls $REPOSITORY/target/ | grep '.jar' | grep -v '.original')
JAR_PATH=$REPOSITORY/target/$JAR_NAME

nohup java -jar $JAR_PATH > /dev/null 2> /dev/null < /dev/null &
