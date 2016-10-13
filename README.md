## send code 发送短信验证码
```
curl -X POST -d "cell=xxxxxx" http://localhost/api/send_code
200: ok
422: ng
```
## signup
```
curl -X POST -d "user[cell]=xx&user[password]=xx&user[code]=xx&user[invite_cell]=xxxx&user[name]=xxx" http://localhost/api/signup
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
### 产品列表
```
curl -X GET --header "Authorization: Token token=#{token}, cell=xxxxxxxxxxx" -d "" http://localhost/api/products
产品信息
```
### 产品推荐列表
```
curl -X GET --header "Authorization: Token token=#{token}, cell=xxxxxxxxxxx" -d "" http://localhost/api/products/recommend_list
产品信息
```
### 产品详细信息
```
curl -X GET --header "Authorization: Token token=#{token}, cell=xxxxxxxxxxx" -d "" http://localhost/api/products/#{id=1}
产品信息
```
### 保单列表
```
curl -X GET --header "Authorization: Token token=#{token}, cell=xxxxxxxxxxx" -d "" http://localhost/api/records
保单列表
id、产品名称、保费、保单号、销售日期、生效日期、失效日期、奖励、提成
```
### 保单查询
```
curl -X GET --header "Authorization: Token token=#{token}, cell=xxxxxxxxxxx" -d "" http://localhost/api/records/search?product_name=&policy_no=
保单列表
id、产品名称、保费、保额、保单号、生效日期、失效日期、销售日期、奖励、提成
```
### 区间收益情况
```
curl -X GET --header "Authorization: Token token=#{token}, cell=xxxxxxxxxxx" -d "" http://localhost/api/records/period_bonus?start_date=2010-01-01&end_date=2020-01-01
获取时间段内的收益统计汇总
总销售数量、总销售额、总奖励、总提成
```
