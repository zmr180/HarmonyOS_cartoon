import MyBar from "../components/MyBar"
import { getCategory, getBookList } from "../../api/request"
import {router} from "@kit.ArkUI"
import { classifyList, classifyData, classifyListArr } from "../../common/iface"

@Entry
@Component
struct Classify {
  @State category: Array<classifyList> = []
  @State end: Array<classifyList> = []
  @State free: Array<classifyList> = []
  @State data: Array<classifyData> = []
  @State cateid: number | string = 1
  @State isEnd: number | string = 0
  @State isFree: number | string = 0
  private scroller: Scroller = new Scroller()

  async onPageShow() {
    await getCategory()
      .then(
        (data) => {
          let str: string = (data.result + "") as string;
          let obj = JSON.parse(str) as object;
          // console.log(str)
          let arr = obj?.['data'] as Array<classifyListArr>
          this.category = arr?.['category']
          this.end = arr?.['end']
          this.free = arr?.['free']
          // console.log(JSON.stringify(arr))
        }
      )
    // {cateid:this.cateid,end:this.isEnd,free:this.isFree,sort:0,p:1,n:21}
    // console.log("cateid:"+this.cateid,"end:"+this.isEnd,"free:"+this.isFree,"sort:"+0,"p:"+1,"n:"+21)
    await getBookList()
      .then(
        (data) => {
          let str: string = (data.result + "") as string;
          let obj = JSON.parse(str) as object;
          this.data = obj?.['data']
          // console.log("111")
          // console.log(JSON.stringify(this.data))
        }
      )
  }

  async getBookListFn(){
    await getBookList({cateid:this.cateid,end:this.isEnd,free:this.isFree,sort:0,p:1,n:21})
      .then(
        (data) => {
          let str: string = (data.result + "") as string;
          let obj = JSON.parse(str) as object;
          this.data = obj?.['data']
          console.log(JSON.stringify(this.data))
        }
      )
}

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          Column() {
            Row() {
              Scroll(this.scroller) {
                Row() {
                  ForEach(this.category, (item: classifyList) => {
                    Row() {
                      Text(item.title).margin({ right: 10 }).fontColor(item.id == this.cateid ? "#ff7779" : "#000").width("50")
                        .onClick(() => {
                          this.cateid = item.id
                          this.getBookListFn()
                        })
                    }
                  })
                }.justifyContent(FlexAlign.SpaceBetween)
              }
              .width("100%")
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.On) // 滚动条常驻显示
              .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
              .scrollBarWidth(0) // 滚动条宽度
              .edgeEffect(EdgeEffect.None)
            }

            Row() {
              ForEach(this.end, (item: classifyList) => {
                Row() {
                  Text(item.title).fontColor(item.id == this.isEnd ? "#ff7779" : "#000")
                }.width("50").margin({ right: 10 })
                .onClick(() => {
                  this.isEnd = item.id
                  this.getBookListFn()
                })
              })
            }.width("100%").margin({ top: 10 })

            Row() {
              ForEach(this.free, (item: classifyList) => {
                Row() {
                  Text(item.title).fontColor(item.id == this.isFree ? "#ff7779" : "#000")
                    .onClick(() => {
                      this.isFree = item.id
                      this.getBookListFn()
                    })
                }.width(50).margin({ right: 10 })
              })
            }.width("100%").margin({ top: 10 })
          }.padding({ left: 10, right: 10 })

          Column() {
            GridRow({
              columns: 3,
              gutter: { x: 10, y: 10 },
              breakpoints: {
                value: ["400vp", "600vp", "800vp"],
                reference: BreakpointsReference.WindowSize
              },
              direction: GridRowDirection.Row
            }) {
              ForEach(this.data, (item: classifyData) => {
                GridCol({
                  span: {
                    xs: 1,
                    sm: 2,
                    md: 3,
                    lg: 4
                  }
                }) {
                  Column() {
                    Row() {
                      Image(item.pic).width("100%").height(150)
                    }

                    Row() {
                      Text(item.title)
                        .margin({ top: 5 })
                        .maxLines(1)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                    }
                  }             .onClick(()=>{
                    // console.log(`${i.id}`)
                    router.pushUrl({
                      url: "pages/Detail",
                      params:{
                        id:item.id
                      }
                    })
                  })
                }
              })
            }
          }.margin({ top: 10 })
          .padding({ left: 10, right: 10 })
        }

      }
      .width("100%")
      .scrollable(ScrollDirection.Vertical) // 滚动方向：水平
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .height("90%")
      .align(Alignment.Top)

      MyBar({ n: 1 }).height("10%")
    }
    .backgroundColor('#F5F5F5')
  }
}