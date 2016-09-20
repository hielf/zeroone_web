## send code
```
curl -X POST -d "cell=xxxxxx" http://localhost/api/send_code
200: ok
422: ng
```
## signup
```
curl -X POST -d "user[cell]=xx&user[code]=xx&user[password]=xxx&user[openid]=xxxxxxxx&user[invite_code]=xxxx" http://localhost/api/signup
201 ok
```
## login
```
curl -X POST -d "cell=xxx&code=1111&openid=xxxxxx" http://localhost/api/login
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
