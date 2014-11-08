# ilo-login-check

## Useage

````
ilo-login-check -u **USERNAME** -p **PASSWORD** [SERVER...]
````

* -u : username  
* -p : password  
* [SERVER...] : ilo ip list

## Example

````
$ ./ilo-login-check.sh -u user1 -p password 10.200.{129,130}.{20..22}
* ./ilo-login-check.sh
* Login to 10.200.129.20 failed.
* Login to 10.200.129.21 successfully.
* Login to 10.200.129.22 successfully.
* Login to 10.200.130.20 failed.
* Login to 10.200.130.21 successfully.
* Login to 10.200.130.22 successfully.
-------------------------------------
Summary
-------------------------------------
Successful login: (total 4)
10.200.129.21 10.200.129.22 10.200.130.21 10.200.130.22
Failed login:     (total 2)
10.200.129.20 10.200.130.20

````
