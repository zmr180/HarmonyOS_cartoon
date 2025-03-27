import { router } from '@kit.ArkUI';
import { getShowChapter, getListChapter } from "../../api/request"
import { showChapter, piclist, listChapter } from "../../common/iface"

@Entry
@Component
struct ShowChapter {
  @State paramsFrom: object = router.getParams()
  private swiperController: SwiperController = new SwiperController()
  scroller: Scroller = new Scroller()
  @State Id: number = this.paramsFrom?.['id']
  @State Bid: number = this.paramsFrom?.['Bid']
  @State showChapter: showChapter = {
    name: "",
    piclist: [],
    id_last: 0,
    id_next: 0
  }
  @State listChapter: listChapter = {
    id: 0,
    name: "",
    cover: ""
  }

  async onPageShow() {
    // 获取漫画内容
    await getShowChapter({ id: this.Id })
      .then(
        (content) => {
          let str: string = (content.result + "") as string;
          let obj = JSON.parse(str).data as object;
          // console.log(JSON.stringify(obj))
          let data = obj as showChapter
          this.showChapter = data
          // console.log(`下一话的id:${this.showChapter.id_next}`)
        }
      )
    // 获取目录
    await getListChapter({ id: this.Bid })
      .then(
        (content) => {
          let str: string = (content.result + "") as string;
          let obj = JSON.parse(str).data as object;
          // console.log(JSON.stringify(obj))
          let listChapter = obj as listChapter
          this.listChapter = listChapter
        }
      )
  }

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          ForEach(this.showChapter.piclist, (item: piclist) => {
            Image(item.url).width("100%")
          })
        }.padding({
          left: 0,
          right: 0
        })
      }
      .width("100%")
      .scrollable(ScrollDirection.Vertical) // 滚动方向：水平
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .height("90%")

      Row() {
        Image($r("app.media.back")).width(30).height(30)
          .onClick(() => {
            this.Id = this.showChapter.id_last
            this.onPageShow()
          })
        Text(this.showChapter.name).onClick(() => {
          console.log("漫画中的Bid:"+this.Bid)
          router.pushUrl({
            url: "pages/BMenu",
            params:{
              Bid:this.Bid
            }
          })
        })
        Image($r("app.media.next")).width(30).height(30)
          .onClick(() => {
            this.Id = this.showChapter.id_next
            this.onPageShow()
          })
      }
      .width("100%")
      .height("10%")
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: 10,
        right: 10
      })
    }
  }
}