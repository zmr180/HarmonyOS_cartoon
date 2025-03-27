import MyBar from "../components/MyBar"
import IndexList from "../components/IndexList"
import { getHome } from "../../api/request"
import { banner, tab } from "../../common/iface"
import MyBanner from "../components/Mybanner"
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State banner: Array<banner> = []
  @State tab: Array<tab> = []
  scroller: Scroller = new Scroller()

  async onPageShow() {
    await getHome()
      .then(
        (content) => {
          let str: string = (content.result + "") as string;
          let obj = JSON.parse(str).data as object;
          // console.log(JSON.stringify(obj))
          let banner = obj?.["recommend"] as Array<banner>
          this.banner = banner
          let tab = obj?.["tab"] as Array<tab>
          // console.log(JSON.stringify(tab))
          this.tab = tab
        }
      )
  }

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          Row() {
            TextInput({ placeholder: "请输入关键字" }).width("85%").margin({ right: 5 })
              .onClick(() => {
                //   跳转
                router.pushUrl({
                  url: "pages/ASearch"
                })
              })
            Image($r('app.media.search')).width("8%")
          }.padding({ left: 10, right: 10 })
          .margin({ bottom: 10 })

          MyBanner({ arr: this.banner })
            .height(275)
            .borderRadius("10")
          IndexList({ tab: this.tab })
        }
      }
      .width("100%")
      .scrollable(ScrollDirection.Vertical) // 滚动方向：水平
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .height("90%")

      MyBar({ n: 0 }).height("10%")
    }
    .backgroundColor('#F5F5F5')
  }
}
