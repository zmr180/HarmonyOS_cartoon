import { getSearch, getsohot } from '../../api/request'
import { hotList, searchList } from '../../common/iface'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ASearch {
  @State hotList: Array<hotList> = []
  @State isShow: boolean = false
  @State text: string = ""
  @State searchList: Array<searchList> = []
  private scroller: Scroller = new Scroller()

  async onPageShow() {
    await getsohot().then(
      (content) => {
        let str: string = (content.result + "") as string;
        let obj = JSON.parse(str).data as object;
        // console.log(JSON.stringify(obj))
        this.hotList = obj?.["list"] as Array<hotList>
        // console.log(JSON.stringify(this.hotList))
      }
    )
  }

  async onSearch() {
    this.isShow = false
    let text = encodeURIComponent(this.text)
    await getSearch({ keyword: text }).then(
      (content) => {
        let str: string = (content.result + "") as string;
        let obj = JSON.parse(str).data as object;
        // console.log(JSON.stringify(obj))
        this.searchList = obj?.["list"] as Array<searchList>
      }
    )
  }

  build() {
    Column() {
      Row() {
        TextInput({ placeholder: "请输入关键字" }).width("85%").margin({ right: 5 })
          .onChange((value: string) => {
            // console.log(value);// 输入框的值
            this.text = value;
          })
        Image($r('app.media.search')).width("8%")
        .onClick(() => {
          this.onSearch()
        })
      }
      .padding({ left: 10, right: 10 })
      .margin({ bottom: 10 })

      Row() {
        if (this.isShow) {
          ForEach(this.hotList, (item: hotList) => {
            Row() {
              Text(item.title)
                .onClick(() => {
                  router.pushUrl({
                    url: "pages/Detail",
                    params: {
                      id: item.id
                    }
                  })
                })
            }.height(30)
          })
        } else {
          Scroll(this.scroller) {
            Column() {
              ForEach(this.searchList, (item: searchList) => {
                Row() {
                  Column() {
                    Image(item.pic).height(150).margin({ right: 10 })
                  }

                  Column() {
                    Row() {
                      Text(item.title).width("100%").fontSize(18).margin({bottom:10})
                    }

                    Row() {
                      Text(item.author).width("100%").fontSize(14).margin({bottom:10})
                    }

                    Row() {
                      Text(item.tag).width("100%").fontSize(14).margin({bottom:10})
                    }

                    Row() {
                      Text(item.info).width("60%").fontSize(14)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                        .maxLines(3)
                    }.width("100%")
                  }.align(Alignment.Start)
                }.width("100%").height(160)
                .padding({
                  left: 10,
                  right: 10
                })
                .onClick(() => {
                  router.pushUrl({
                    url: "pages/Detail",
                    params: {
                      id: item.id
                    }
                  })
                })
              })
            }
          }
          .width("100%")
          .scrollable(ScrollDirection.Vertical)
          .scrollBar(BarState.On) // 滚动条常驻显示
          .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
          .scrollBarWidth(10) // 滚动条宽度
          .edgeEffect(EdgeEffect.None)
          .align(Alignment.Start)
        }
      }

    }
  }
}