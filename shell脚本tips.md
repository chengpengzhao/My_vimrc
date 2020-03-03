# 基础知识

## 常见符号及命令
- `chmod +x test.sh`——赋予脚本执行权限
- `./test.sh`——告诉Linux在当前路径寻找，而不是`PATH`环境变量中
- `;`——命令分隔符，用来在一行放置多个命令
- `;;`——`case`条件语句终止符
- `,`——将表达式串联，或连接字符串
- `` ` ``——命令替换符，将输出结果赋值给变量
- `:` ——空冒号，返回值为`true`
- `!`—— 取反   
- `()`——命令组，产生一个子shell，内部变量不可见
- `[ ]`—— 条件测试，注意空格很重要！
- 常见条件判断：
```bash
[ -f "somefile" ] #判断文件是否存在
[ -d "path" ] #判断文件夹是否存在
[ -x "/bin/ls" ] #判断/bin/ls是否存在并有可执行权限
[ -n "$var" ] #判断$var变量是否有值
[ "$a" = "$b" ] #判断$a和$b是否相等
```
- `let "t2 = ((a = 9, 15 / 3))" # a被赋值为9，t2被赋值为15 / 3 `
## 变量
- `a="hello world!"`——变量名不加`$`符号，但等号和变量名之间**不允许有空格**
- ``a= `ls /home` `` ——利用命令给变量赋值
- `echo ${a}`——引用定义过的变量，花括号可以不加，但推荐加
- `${a:-defaultvalue}`——a没有定义或者为空字符串，则表达式返回默认值，否则返回a的值；
- `# 这是一条注释`——单行注释（没有多行）
- `str='a string'`——单引号（或双引号）表示字符串，**注意单、双引号的区别**：
1. 单引号：所见即所得，被引内容不会被解释替换，如：
```bash
var=dablelv
echo '$var'
```
运行结果为`$var`  
    1). 字符原样输出，字符串中变量无效  
    2). 单引号中不能出现单引号（使用转义符也不行）  

2. 双引号：所见非所得，如果内容中有命令、变量等，会先把变量、命令解析出结果，然后在输出最终内容。双引号是部分引用，被双引号括起的内容常量还是常量，变量则会发生替换，替换成变量内容。如：
```bash
var=dablelv
echo "$var"
```
运行结果为`dablelv`  
1). 双引号里可以有变量  
2). 可以出现转义字符  
- 字符串操作：  `echo ${#string}`输出字符串长度； `echo ${string:0:4}`提取子字符串

- 预定义变量：
```bash
$0 ：脚本文件名
$1-9 ：第 1-9 个命令行参数名
$# ：命令行参数个数
$@ ：所有命令行参数
$* ：所有命令行参数
$? ：前一个命令的退出状态，可用于获取函数返回值
$$ ：执行的进程 ID
```

- 运算：
```bash
1. m=$[ m + 1 ]    #常用这种
2. m=`expr $m + 1 `# 用`字符包起来
3. let m=m+1
4. m=$(( m + 1 ))
```

## 流程控制

- sh的流程控制不能为空！
- `if语句`：
```bash
# 下面这两种判断方法都可以，使用 [] 注意左右加空格
#if test $VAR -eq 10
if [ $VART -eq 10 ]
then
    echo "true"
    break   # 跳出循环
else
    echo "false"
    continue   #跳出本次循环
fi
```

- `case语句`：
```bash
read NAME
# 格式有点复杂，一定要注意
case $NAME in
    "Linux")
        echo "Linux"
        ;;
    "cdeveloper")
        echo "cdeveloper"
        ;;
    *)
        echo "other"
        ;;
esac
```
- `for循环`：
```bash
# 普通 for 循环
for ((i = 1; i <= 3; i++))
do
    echo $i
done
# VAR 依次代表每个元素 
for VAR in 1 2 3
do
    echo $VAR
done
```
- `while循环`：
```bash
while [ $VAR -lt 10 ]
do
    echo $VAR
#   VAR 自增 1
    VAR=$[ $VAR + 1 ]
done
```


## 函数

- 定义函数：
```bash
function fun_name()
{
}
fun_name()
{
}
```


## 无限循环
```bash
while :
do          # 无限循环
    ...
done
```

## 某条件分支中什么也不做
```bash
if condition
then:   #什么也不做，跳出判断
else
    ...
fi
```

<br><br><br><br><br><br>


# 实用Tips


## 将文件清空
```bash
: > data.txt   #将文件data清空（不存在将会创建）
#与 cat /dev/null > data.txt 作用相似，但不产生新进程
```

## `#!/bin/bash`、 `#!/bin/sh`、`#!/usr/bin/env bash`
指定脚本解释器，推荐用第三种：  
>脚本用env启动的原因，是因为脚本解释器在linux中可能被安装于不同的目录，env可以在系统的PATH目录中查找。同时，env还规定一些系统环境量。 而如果直接将解释器路径写死在脚本里，可能在某些系统就会存在找不到解释器的兼容性问题。有时候我们执行一些脚本时就碰到这种情况。

## echo自定义颜色
```bash
Black="\033[0;30m"        # Black
Red="\033[0;31m"          # Red
Green="\033[0;32m"        # Green
Yellow="\033[0;33m"       # Yellow
Blue="\033[0;34m"         # Blue
Purple="\033[0;35m"       # Purple
Cyan="\033[0;36m"         # Cyan
White="\033[0;37m"        # White
Font="\033[0m"
#用法：
echo "${Green}Hello world${Font}"
```

## 使用`cat EOF`编辑文件
```bash
# 运行下列命令即可将内容写入文件，若不存在则会创建，若存在则会覆盖
# 将 `cat > `改为`cat >>`则是向文件末尾添加
sudo bash -c "cat > /etc/hosts" <<EOF
127.0.0.1  localhost
192.168.1.101 master1
192.168.1.102 worker1
192.168.1.103 worker2
192.168.1.104 worker3
EOF
```

## 检查root权限
```bash
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
Info="[${Green_font_prefix}信息${Font_color_suffix}]"
Error="[${Red_font_prefix}错误${Font_color_suffix}]"
Tip="[${Green_font_prefix}注意${Font_color_suffix}]"
[[ $EUID != 0 ]] && echo -e "${Error} \
当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用 \
${Green_background_prefix}sudo su${Font_color_suffix} \
命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。\
" && exit 1
```



## 脚本在当前路径下运行
```bash
#!/bin/bash
cd ${0%/*} || exit 1    # Run from this directory
```

## `cp`跳过相同文件
- cp的` -a`标识，作用是对已存在的文件进行比较，若相同则跳过，很实用
```bash
cp -a  target local
```

## tree生成文件目录树，输出成html
```bash
tree . -H .    >    index.html
```

## 一例github上传脚本

```bash
date=$(date '+%Y-%m-%d %H:%M')
git add -A
git commit -m "update at $date"
git push

#或者每次读取用户输入：
git add -A
echo -n  "please enter a commit ->"
read  commit
# 或者用一行代替上面两行：
# read -p "please enter a commit ->" commit
git commit -m "$commit"
git push
```

## 处理带空格的文件名
```bash
#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
#使用IFS（the Internal Field Separator），Shell依靠它去决定如何进行单词分隔。
for f in *
do
  echo "$f"
done

IFS=$SAVEIFS
```

## VPS后台运行
```bash
nohup ./test.sh  >/dev/null 2>&1 &
```

## 用cat输出带颜色字符到屏幕
```bash
# 这里很奇怪，要把\033换成    (都是表示Esc)
# 并且要去掉'0;'，和前面的对比一下：
# Green="\033[0;32m"        # Green
Green="[32m"
Font="[0m"
Yellow="[33m"       # Yellow
cat<<EOF
${Green}Hello ${Yellow}world${Font}
EOF
```

## 让用户判断Y/N
```bash
# 举个例子
read -p "是否需要修改"$USER"用户名（y/n）：" chid
until [[ $chid =~ ^([y]|[n])$ ]]; do
    read -p "输入错误！请重新键入是否需要修改"$USER"用户名（y/n）：" chid
done
if [[ $chid == y ]]; then
    read -p "请指定自定义""$USER""用户名：" username;username=${username:-admin}
fi
```

## 判断上一个命令执行成功
```bash
# echo $?返回0时，表示执行成功，举个例子：
if [[ $answer== y ]]; then
    echo 更改用户"$USER"密码
        passwd
    until [[ `echo $?` == "0" ]]; do
        passwd
    done
fi
```
## 利用sed替换部分文件内容
```bash
Port=1234
echo 更改SSH端口号为$Port
# 替换Port .*为Port $Port
sed -i "s/Port .*/Port $Port/" /etc/ssh/sshd_config
echo 重启SSH服务...
service sshd restart
```
```bash
echo "Disabled password login in SSH."
# 搜索PasswordAuthentication所在行，c\表示用后面的内容替换该行
sed -i '/PasswordAuthentication /c\PasswordAuthentication no' $PREFIX/etc/ssh/sshd_config
```
