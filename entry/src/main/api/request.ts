//第一步： 导入网络模块
import http from '@ohos.net.http';
import api from './index'
//封装GET请求
// 网络请求 是否基于promise
const get =  (url:string,data={})=> {
  // 把 'data' 拼接成 'str'
  let str = '';
  if(data){
    for(let key in data){
      str+=key+"="+data[key]+"&"
    }
    str = str.slice(0,str.length-1);
    // console.log(str);
  }
  // 创建请求任务
  let httpRequest = http.createHttp();
  // 调用request方法返回promise
  return httpRequest.request(
    str ? url+"?"+str: url,  // 请求地址
    {
      method: http.RequestMethod.GET,// 请求方式
      connectTimeout: 60000,
      readTimeout: 60000,
      header: {
        'Content-Type': 'application/json' // 请求头信息
      }
    })
}
//封装POST请求
const post =  (url:string,data={})=> {
  // 把 'data' 拼接成 'str'
  let str = '';
  if(data){
    for(let key in data){
      str+=key+"="+data[key]+"&"
    }
    str = str.slice(0,str.length-1);
    // console.log(str);
  }
  // 把参数拼接成 “account=123@qq.com&password=12312312”
  // 创建请求任务
  let httpRequest = http.createHttp();
  // 调用request方法返回promise
  return httpRequest.request(
    url,  // 请求地址
    {
      method: http.RequestMethod.POST,// 请求方式
      // extraData: data, //错误的写法
      // extraData: {’data‘:data},//错误的写法
      extraData: str,
      // 传递参数给后台
      connectTimeout: 60000,
      readTimeout: 60000,
      header: {
        'Content-Type': 'application/x-www-form-urlencoded' // 请求头信息
      },
      //返回数据类型
      expectDataType: http.HttpDataType.STRING,
    })
}

//获取首页内容
export const getHome=(data={})=>{
  return get (`${api.host}/index/index`)
}
//获取所有分类
export const getCategory=()=>{
  return get(`${api.host}/category/list`)
}
//获取分类列表
export const getBookList=(data={})=>{
  return get(`${api.host}/book/list`,data)
}
//获取漫画详情
export const getBookShow=(data={})=>{
  return get(`${api.host}/book/show`,data)
}
//获取漫画评论
export const getComment=(data={})=>{
  return get(`${api.host}/comment/list`,data)
}

//获取漫画目录
export const getListChapter=(data={})=>{
  return get(`${api.host}/book/listChapter`,data)
}
//获取漫画内容
export const getShowChapter=(data={})=>{
  return get(`${api.host}/book/showChapter`,data)
}

//获取热门搜索
export const getsohot=(data={})=>{
  return get(`${api.host}/so/hot`,data)
}

//获取搜索列表
export const getSearch=(data={})=>{
  return get(`${api.host}/so/comic`,data)
}