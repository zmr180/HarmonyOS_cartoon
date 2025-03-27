import {router} from "@kit.ArkUI"

interface  tabItem{
  text: string
  id:number
  path:string
}

@Component
export default struct MyBar {
  @Prop n:number
  @State num:number=this.n
  public tabArray:Array<tabItem> = [
    {
      text: "首页",
      id: 0,
      path:"pages/Index"
    },
    {
      text: "分类",
      id: 1,
      path:"pages/Classify"
    },
    {
      text: "收藏",
      id: 2,
      path:"pages/Collection"
    },
    {
      text: "我的",
      id: 3,
      path:"pages/My"
    }
  ];


  build() {
    RelativeContainer(){
      Column(){
        Row(){
          ForEach(this.tabArray,(item:tabItem,i:number)=>{
            Column(){
              Text(item.text).fontSize(20).fontColor(this.num==i?"#ff7779":"#000")
            }.width("25%")
            .padding({top:10,bottom:10})
            .onClick(()=>{
              router.pushUrl({url:item.path})
            })
          })
        }.width("100%")
      }.position({
        left:0,bottom:0
      })
      .backgroundColor("#f0f0f0")
    }
  }
}