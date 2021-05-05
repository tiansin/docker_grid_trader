# 网格交易策略

## 为什么要使用此策略
1. 网格交易策略风险小,回撤率低,收益靠谱
2. 基本不用人工干预,可在服务器24小时挂机
3. 非常适合币圈行情

### 环境要求
1. 安装 docker
2. 安装 docker-compose

### Centos7安装参考(推荐): 
 - [https://www.cnblogs.com/ruanqin/p/11082506.html](https://www.cnblogs.com/ruanqin/p/11082506.html)

#### Win10安装参考: 
 - [https://www.cnblogs.com/makalochen/p/14286100.html](https://www.cnblogs.com/makalochen/p/14286100.html)

#### Ubuntu安装参考:
 - [https://www.jianshu.com/p/482d1eb4d9a2](https://www.jianshu.com/p/482d1eb4d9a2)

### 第一步 注册币安账号

- 注册币安账号返佣10%
   - [https://accounts.binancezh.io/zh-CN/register?ref=F6P7LQM3](https://accounts.binancezh.io/zh-CN/register?ref=F6P7LQM3)
   - ![image](https://github.com/tiansin/docker_grid_trader/blob/master/qr.jpeg)

- 生成API密钥:
  - [https://www.binance.com/zh-CN/my/settings/api-management](https://www.binance.com/zh-CN/my/settings/api-management)

### 第二步 创建并修改`docker-compose.yml`配置文件

docker-compose.yml 文件内容
```yml
version: '2'

services:
  binance_grid_trader:
    image: tiansin/binance_grid_trader:latest
    restart: always
    environment:
      PLATFORM: "binance_spot"
      SYMBOL: "BNBUSDT"
      API_DOMAIN: "binancezh.co"
      API_KEY: ""
      API_SECRET: ""
      GAP_PERCENT: 0.01
      QUANTITY: 1
      MIN_PRICE: 0.0001
      MIN_QTY: 0.01
      MAX_ORDERS: 1
      PROXY_HOST: ""
      PROXY_PORT: 0
    logging:
      options:
        max-size: 10m
        max-file: "3"
```

修改其中的环境变量
```yml
  PLATFORM: "binance_spot"
  SYMBOL: "BNBUSDT"
  API_DOMAIN: "binance.com"
  API_KEY: "API密钥的 API Key"
  API_SECRET: "API密钥的 Secret Key"
  GAP_PERCENT: 0.01
  QUANTITY: 1
  MIN_PRICE: 0.0001
  MIN_QTY: 0.01
  MAX_ORDERS: 1
  PROXY_HOST: ""
  PROXY_PORT: 0
```

1. `PLATFORM` 是交易的平台, 填写 binance_spot (现货) 或者 binance_future (合约)
2. `SYMBOL` 交易对: BTCUSDT, BNBUSDT等
3. `API_DOMAIN` API的域名, 由于大陆网络无法访问币安API, 需要`配置代理`或者购买`香港`或海外服务器进行配置, 本地测试或条件有限可以配置成`binancezh.co`(偶尔有延时)
4. `API_KEY` : 从交易所获取,第一步生成的API密钥
5. `API_SECRET`: 交易所获取,第一步生成的API密钥
6. `GAP_PERCENT`: 网格交易的价格间隙
7. `QUANTITY` : 每次下单的数量
8. `MIN_PRICE`: 价格波动的最小单位, 用来计算价格精度： 如BTCUSDT 是0.01,
   BNBUSDT是0.0001, ETHUSDT 是0.01, 这个价格要从交易所查看，每个交易对不一样。
   
9. `MIN_QTY`: 最小的下单量, 现货B要求最小下单是10USDT等值的币, 而对于合约来说,BTCUSDT要求是0.001个BTC
10. `MAX_ORDERS`: 单边的挂单量,超过则取消之前的挂单
11. `PROXY_HOST`: 如果需要用代理的话，请填写你的代理,如: 127.0.0.1
12. `PROXY_PORT`: 代理端口号,如: 8080


### 第三步 上传配置文件并启动服务
1. 把修改好的`docker-compose.yml`文件上传到 `/usr/src/` 目录
2. 执行命令`cd /usr/src && docker-compose up -d`
3. 使用命令`docker-compose logs -f`可以查看执行日志,检查程序运转是否正常
   
## 提供一些本人在正式环境跑过的一些配置模板

*需替换密钥,可按照您的资金配比修改下单的数量,有需要可以配置代理*

- DOGEUSDT 
```yml
PLATFORM: "binance_spot"
SYMBOL: "DOGEUSDT"
API_DOMAIN: "binance.com"
API_KEY: "API密钥的 API Key"
API_SECRET: "API密钥的 Secret Key"
GAP_PERCENT: 0.016
QUANTITY: 100
MIN_PRICE: 0.00001
MIN_QTY: 50
MAX_ORDERS: 1
PROXY_HOST: ""
PROXY_PORT: 0
```

- BNBUSDT 
```yml
PLATFORM: "binance_spot"
SYMBOL: "BNBUSDT"
API_DOMAIN: "binance.com"
API_KEY: "API密钥的 API Key"
API_SECRET: "API密钥的 Secret Key"
GAP_PERCENT: 0.011
QUANTITY: 0.1
MIN_PRICE: 0.01
MIN_QTY: 0.05
MAX_ORDERS: 1
PROXY_HOST: ""
PROXY_PORT: 0
```

- CAKEUSDT 
```yml
PLATFORM: "binance_spot"
SYMBOL: "CAKEUSDT"
API_DOMAIN: "binance.com"
API_KEY: "API密钥的 API Key"
API_SECRET: "API密钥的 Secret Key"
GAP_PERCENT: 0.015
QUANTITY: 1.0
MIN_PRICE: 0.001
MIN_QTY: 0.5
MAX_ORDERS: 1
PROXY_HOST: ""
PROXY_PORT: 0
```

- MATICUSDT 
```yml
PLATFORM: "binance_spot"
SYMBOL: "MATICUSDT"
API_DOMAIN: "binance.com"
API_KEY: "API密钥的 API Key"
API_SECRET: "API密钥的 Secret Key"
GAP_PERCENT: 0.016
QUANTITY: 50
MIN_PRICE: 0.00001
MIN_QTY: 20
MAX_ORDERS: 1
PROXY_HOST: ""
PROXY_PORT: 0
```

## 网格交易策略适合行情
- 震荡行情
- 适合币圈的高波动率的品种
- 适合现货， 如果交易合约，需要注意防止极端行情爆仓。

