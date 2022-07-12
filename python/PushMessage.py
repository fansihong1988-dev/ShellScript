#!/usr/bin/python3

import requests
# 获取企业微信 'access_token'
def getAccessToken(corpids,secrets):
    url = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid={0}&corpsecret={1}'.format(corpids,secrets)
    req = requests.get(url)
    ret = req.json()['access_token']
    return ret
# 通过 getAccessToken函数，返回access_token值传入函数，并推送消息。
def pushMessage():
    url = 'https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token={0}'.format(getAccessToken(corpids='ww08e3548004b4e7e8',secrets='MQwxLC_o75ve03GLTOIaTZ9A-mt1dbRlSvRrwW4PXqI'))
    
    data={"touser": "FanSiHong",
          "msgtype": "text",
          "agentid": 1000003,
          "text": {
            "content": "我就推送测试一下"
          },
          "safe": 0}
    post = requests.post(url,json=data)

    return post.json()

