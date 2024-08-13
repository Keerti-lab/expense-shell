#!/bin/bash

USERID=$(id -u)

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
Y="\e[33m"
N="\e[0m"
G="\e[32m"

VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e  "$2... $Y SUCCESS $N"
    fi
}


if [ $USERID -ne 0 ]
then
    echo "Please run using root acess"
    exit 1

else    
    echo "you are super user"
fi


dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySql Server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling MYSql Server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting MYSql Server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "Setting up root Password"
