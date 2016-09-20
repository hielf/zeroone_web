## send code 发送短信验证码
```
curl -X POST -d "cell=xxxxxx" http://localhost/api/send_code
200: ok
422: ng
```
## signup
```
curl -X POST -d "user[cell]=xx&user[password]=xx&user[password]=xxx&user[invite_cell]=xxxx" http://localhost/api/signup
201 ok
```
## login
```
curl -X POST -d "cell=xxx&password=1111" http://localhost/api/login
200: ok
401: ng
```
### reset password
```
curl -X PATCH --header "Authorization: Token token=#{token}, cell=xxxxxxxxxxx" -d "old_password=xxx&password=xxx" http://localhost/api/users/reset_password
token changed!!
```
### user center
```
curl -X GET --header "Authorization: Token token=#{token}, cell=xxxxxxxxxxx" http://localhost/api/users/center
```
