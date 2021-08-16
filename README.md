> 只支持python2.7!!
>
> 有conda环境就必须用control_conda.sh
> 
> contol脚本中的set -e注释掉才能看到错误信息, 如果缺少啥库直接装或者改名(这句话如果没看懂那你就傻傻的装库就行)
>
> 如果注释了set -e 启动时没报错还是访问不了, 通常是端口冲突, 可以在log里看到
> 
> 这个仓库使用control_conda.sh启动可以直接用, 端口12345
> 
> `[BUG]` 更新 2021-08-16: 修复了源码中react代码的bug `父子组件属性传递问题`- `showLoading` | `hidLoading` |  `...`
> 
>  `[TIPS]` 更新2021-08-16: uwsgi的配置文件中processes不应大于1, 因为sqlite3不支持并发的连接
> 
> `[Dependency]` 更新2021-08-16: 解决abc导入失败
>
> `[BUG]` 更新2021-08-06: `messageCallback is not a function`
>
> `[BUG]` 更新2021-08-06: label异常问题: 0 和 0.0 解析不一致

# Problem 1: --no-site-packages

> virtualenv: error: unrecognized arguments: --no-site-packages

更新版本的virtualenv 不需要--no-site-packages, 已经是自带了, 删除control.sh中的--no-site-packages 即可

# Problem 2: Failed building wheel for uwsgi

在ubuntu上, gcc为gcc-7或者gcc-8, 编译uwsgi需要gcc-4.8

```shel
sudo apt-get install gcc-4.8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 500
pip install uwsgi
```

# Problem 3: `libpcre.so.1: cannot open shared object file: No such file or directory`

```shell
# 先全局搜索, 不好下载这个lib
find / -name "libpcre"

# 然后改个后缀, 如果能找到

```

# Problem 4: `libssl.so.1.1: cannot open shared object file: No such file or directory`

```shell
sudo apt-get update
sudo apt-get install libssl1.0.0 libssl-dev

cd /lib/x86_64-linux-gnu
sudo ln -s libssl.so.1.0.0 libssl.so.1.1
sudo ln -s libcrypto.so.1.0.0 libcrypto.so.1.1
```

# Problem 5: `ERROR: Package ‘pyrsistent‘ requires a different Python: 2.7.5 not in ‘＞=3.5‘`

```shell
# 在执行 start前手动安装
pip install pyrsistent==0.15.0  # 0.14.0 也行
```

# Tips1: Node.js-`v13.2.0` works properly~

# Tips2: curve/web 是前端构建后的文件夹, 删除即可重新构建

# Tips3: 如果add的数据太大, curve需要比较久的时间来处理

----
Curve
---

**Sorry to tell contributors and users. We decided to archive the project temporarily due to the employee work plan of collaborators.**

**There are no more official support. Collaborators may offer a bit personal support.**

Curve is an open-source tool to help label anomalies on time-series data. The labeled data (also known as the ground truth) is necessary for evaluating time-series anomaly detection methods. Otherwise, one can not easily choose a detection method, or say method A is better than method B. The labeled data can also be used as the training set if one wants to develop supervised learning methods for detection.

Curve is designed to support plugin, so one can equip Curve with customized and powerful functions to help label effectively. For example, a plugin to identify anomalies which are similar to the one you labeled, so you don't have to search them through all the data.

Curve is originally developed by Baidu and Tsinghua NetMan Lab.

<img src="https://raw.githubusercontent.com/baidu/Curve/master/doc/pic/index.png">

## Getting Started

### Run and stop

Simply use control.sh to start or stop Curve.

```bash
./control.sh start
./control.sh stop
```
Server will blind 8080 by default, you can change it in `./api/uwsgi.ini`.

> The first start will take a while because of the compilation. 
> If you pull updates from github, Rebuild will be triggered during start or reload.

### Data format

You can load a CSV file into Curve. The CSV should have the following format

* First column is the timestamp
* Second column is the value
* Third column (optional) is the label. 0 for normal and 1 for abnormal.

The header of CSV is optional, like `timestamp,value,label`.  

Some examples of valid CSV

* With a header and the label column

|timestamp|value|label|
|---|---|---|
|1476460800|2566.35|0|
|1476460860|2704.65|0|
|1476460920|2700.05|0|


* Without the header
 
|1476460800|2566.35|0|
|---|---|---|
|1476460860|2704.65|0|
|1476460920|2700.05|0|

* Without the header and the label column

|1476460800|2566.35|
|---|---|
|1476460860|2704.65|
|1476460920|2700.05|

* Timestamp in human-readable format

|20161015000000|2566.35|
|---|---|
|20161015000100|2704.65|
|20161015000200|2700.05|

## Additional

### Recommend environments

#### For PC

Darwin(Mac OSX) or Linux(Ubuntu, CentOS, Arch, etc.) is Recommended

* Dependency:
    * Python 2.7.3+~~/3.1.2+~~(Python 3 does not seem to be supported as of now.), if python is not owned by current user, virtualenv is required
    * Node.js 4.7.0+
    * gcc, pip and npm path is correctly set

> Control Scripts for Windows is under development

#### For VPS like EC2

**Minimal**

* Server: 1 CPU, 512MB RAM, 5GB Storage
* System: Ubuntu10.04LTS or CentOS5.5

> Swap is required during build

**Recommend**

* Server: 1 CPU, 1GB RAM, 10GB Storage
* System: Ubuntu16.04LTS or CentOS7

### Backend Unit Test

```bash
cd api && pytest
```

### Plugin dir

```api/curve/v1/plugins```

### GitHub oauth

GitHub Oauth is supported, please put a configuration file into ```api/curve/auth/github_oauth.json``` like this:

```json
{
  "id": "your github application Client ID",
  "secret": "your application Client Secret"
}
```

> [Doc:Creating-An-Github-Oauth-App](https://developer.github.com/apps/building-oauth-apps/creating-an-oauth-app/)

### Change Log
* 2018-08-07  [Function Optimization]: Refactoring code
