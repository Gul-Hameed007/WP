#!/usr/bin/env python3
'''
先决条件
pip install qiniu
pip install arrow
pip install requests

执行: python3 qiniu_upload.py fw_crc.bin
执行完毕会输出需要的命令，并且该命令会发送到剪切板。到需要的地方直接粘贴就可以了。
'''

import qiniu
import urllib
import sys
import os
import json
import requests
import arrow
from pprint import pprint

import conf

ACCESS_KEY = 'CjTW1_cw-BsnKphGiKtEdn4Us9gn6lJRTD9kuh8F'
SECRET_KEY = '2EWI0xeAKpqyucSE8PJO4P0DiBWPYczPyBD7_rE8'

BUCKET_NAME = "stm8"
BUCKET_URL = {"stm8": "http://owkdcoyuu.bkt.clouddn.com/"}


class QiNiu(object):
    def __init__(self, access, secret):
        self.access_key = access
        self.secret_key = secret
        self._q = qiniu.Auth(self.access_key, self.secret_key)
        self._bucket = qiniu.BucketManager(self._q)
        self.mcu_url = None
        self.file_list_size = 10

    def delete_file(self, prefix):
        files = self.list_file("fw")
        if len(files) == self.file_list_size:
            ops = qiniu.build_batch_delete(BUCKET_NAME, files)
            ret, info = self._bucket.batch(ops)

    def list_file(self, prefix):
        flist = []
        ret, eof, info = self._bucket.list(BUCKET_NAME, prefix, None,
                                           self.file_list_size, None)
        array = ret.get("items")
        for f in array:
            flist.append(f.get("key"))
        return flist

    def upload_file(self, bucket, up_filename, file_path):
        self.delete_file("fw")
        token = self._q.upload_token(bucket)
        ret, info = qiniu.put_file(token, up_filename, file_path)

        url = self.get_file_url(bucket, up_filename)
        return ret, info, url

    def get_file_url(self, bucket, up_filename):
        if bucket not in BUCKET_URL.keys():
            raise AttributeError("Bucket Name Error")
        url_prefix = BUCKET_URL[bucket]
        url = url_prefix + urllib.parse.quote(up_filename)
        self.mcu_url = url
        return url

    def gen_command(self):
        return '{"method":"miIO.ota","params":{"mcu_url":"' + self.mcu_url + '"}}'

    def post_request(self):
        url = 'https://open.home.mi.com/if/demo_rpc'
        headers = {
            'Origin':
            'https://open.home.mi.com',
            'Accept-Encoding':
            'gzip, deflate, br',
            'Accept-Language':
            'zh-CN,zh;q=0.8',
            'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',
            'Content-Type':
            'application/json;charset=UTF-8',
            'Accept':
            'application/json, text/plain, */*',
            'Referer':
            'https://open.home.mi.com/debug.html',
            'Connection':
            'keep-alive',
            'DNT':
            '1'
        }

        cookies = {'userId': '959174401', 'serviceToken': conf.token}

        payload = {
            "did": conf.did,
            "method": "miIO.ota",
            "params": {
                "mcu_url": self.mcu_url
            }
        }

        r = requests.post(
            url, headers=headers, cookies=cookies, data=json.dumps(payload))
        pprint(r.json())


def add_to_clipboard(text):
    command = 'echo ' + text.strip() + '| clip'
    os.system(command)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        file_name = "../bin/fw_crc.bin"
    else:
        file_name = sys.argv[1]

    file_name = os.path.join(os.getcwd(), file_name)

    q = QiNiu(ACCESS_KEY, SECRET_KEY)

    if os.path.isfile(file_name):
        key = "fw" + arrow.now().format("YYYYMMDDhhmmss") + ".bin"
        ret, info, url = q.upload_file(BUCKET_NAME, key, file_name)
        cmd = q.gen_command()
        print(cmd)
        q.post_request()

if __name__ == '__main__2':
    q = QiNiu(ACCESS_KEY, SECRET_KEY)
    q.list_file("fw")