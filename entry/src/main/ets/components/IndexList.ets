import { tab, list } from "../../common/iface"
import { router } from "@kit.ArkUI"

@Component
export default struct IndexList {
  @Prop tab: Array<tab>
  private scroller: Scroller = new Scroller()

  build() {
    Column() {
      ForEach(this.tab, (item: tab) => {
        Row() {
          Text(item.name)
        }
        .margin({ top: 10, bottom: 10 })
        .width("100%")

        Scroll(this.scroller) {
          Row() {
            ForEach(item.list, (i: list) => {
              Column() {
                Row() {
                  Image(i.pic).width("100%").height(150)
                }.width("100%")

                Row() {
                  Text(i.title)
                    .margin({ top: 5 })
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                }
              }.width("30%")
              .margin({ right: 10 })
              .onClick(() => {
                // console.log(`${i.id}`)
                router.pushUrl({
                  url: "pages/Detail",
                  params: {
                    id: i.id
                  }
                })
              })
            })
          }.justifyContent(FlexAlign.Start)
        }
        .width("100%")
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.On) // 滚动条常驻显示
        .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
        .scrollBarWidth(10) // 滚动条宽度
        .edgeEffect(EdgeEffect.None)
        .align(Alignment.Start)

      })
    }.padding({ left: 10, right: 10 })
  }
}