export  interface banner{
  did:number
  pic: string
}

export interface tab{
  id:number
  name:string
  list:Array <list>
}

export interface list{
  id:number
  author:string
  info:string
  pic:string
  title:string
}

export interface classifyListArr{
  category:Array <classifyList>
  end:Array <classifyList>
  free:Array <classifyList>
  sort:Array <classifyList>
}

export interface classifyList{
  id:number|string
  title:string
}

export interface classifyData{
  id:number
  author:string
  pic:string
  title:string
}

export interface info{
  author:string
  title:string
  tag:string
  info:string
  bigpic:string
  pic:string
  vip:number
  lastchapter:string
  look:string
  num_comment:number
  num_look:number
  num_fav:number
  updatetime:number
  chapterlist2:Array <chapterlist2>
}

export interface chapterlist2{
  id:number
  chapter:string
  name:string
  vip:number
  cover:string
  updatetime:number
}

export interface comment{
  content:string
  ctime:number
  uname:string
  uhead:string
  from:string
}

export interface showChapter{
  name:string
  piclist:Array<piclist>
  id_last:number
  id_next:number
}

export interface piclist{
  url:string
  width:number
  height:number
}

export interface listChapter{
  id:number
  name:string
  cover:string
}

export interface hotList{
  id:number
  title:string
}

export interface searchList{
  id:number
  author:string
  title:string
  tag:string
  info:string
  pic:string
}

export interface menu{
  id:number
  chapter:string
  name:string
  cover:string
  updatetime:number
}