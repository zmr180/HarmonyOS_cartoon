import { router } from '@kit.ArkUI';
import { getListChapter, getBookShow } from "../../api/request"
import { menu, info } from "../../common/iface"
import { FavoriteManager, FavoriteBook } from '../../common/FavoriteManager';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct BMenu {
  private scroller: Scroller = new Scroller()
  @State paramsFrom: object = router.getParams()
  @State Bid: number = this.paramsFrom?.['Bid']
  // @State Bid: number = 1746
  @State data: Array<menu> = []
  @State bookInfo: info = {} as info
  @State isFavorite: boolean = false

  // @State data: menu = {
  //   id: 0,
  //   chapter: "",
  //   name: "",
  //   cover: "",
  //   updatetime: 0
  // }

  // 检查当前漫画是否已收藏
  async checkIsFavorite() {
    this.isFavorite = await FavoriteManager.isFavorite(this.Bid);
  }
  
  // 收藏/取消收藏
  async toggleFavorite() {
    if (this.isFavorite) {
      // 取消收藏
      const success = await FavoriteManager.removeFavorite(this.Bid);
      if (success) {
        this.isFavorite = false;
        promptAction.showToast({
          message: '已取消收藏',
          duration: 2000,
        });
      }
    } else {
      // 添加收藏
      if (!this.bookInfo || !this.bookInfo.title) {
        promptAction.showToast({
          message: '收藏失败，书籍信息不完整',
          duration: 2000,
        });
        return;
      }
      
      const book: FavoriteBook = {
        id: this.Bid,
        title: this.bookInfo.title,
        cover: this.bookInfo.pic,
        author: this.bookInfo.author,
        updateTime: Date.now()
      };
      const success = await FavoriteManager.addFavorite(book);
      if (success) {
        this.isFavorite = true;
        promptAction.showToast({
          message: '收藏成功',
          duration: 2000,
        });
      }
    }
  }

  async onPageShow() {
    console.log("目录漫画id:" + this.Bid)
    
    // 获取漫画章节列表
    await getListChapter({ id: this.Bid }).then(
      (content) => {
        let str: string = (content.result + "") as string;
        let obj = JSON.parse(str).data as Array<menu>;
        // console.log(JSON.stringify(obj))
        this.data = obj
        // console.log(JSON.stringify(this.data))
      }
    )
    
    // 获取漫画基本信息
    await getBookShow({ id: this.Bid }).then(
      (content) => {
        let str: string = (content.result + "") as string;
        let obj = JSON.parse(str).data as info;
        this.bookInfo = obj;
      }
    )
    
    // 检查是否已收藏
    await this.checkIsFavorite();
  }

  getTimeFn(time: number) {
    let dt = new Date(time)
    let y = dt.getFullYear()
    let m = dt.getMonth() + 1
    let d = dt.getDate()
    return `${y}-${m}-${d}`
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Row() {
          Image($r('app.media.back'))
            .width(24)
            .height(24)
            .margin({ right: 10 })
            .onClick(() => {
              router.back()
            })
          Text("漫画目录")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
        }
        
        // 修改收藏图标的显示逻辑，交换状态
        Image(this.isFavorite ? $r('app.media.collection_1') : $r('app.media.collection'))
          .width(24)
          .height(24)
          .margin({ right: 10 })
          .onClick(() => {
            this.toggleFavorite()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)
      
      // 阅读进度提示
      Text(`共${this.data.length}话`)
        .fontSize(14)
        .fontColor('#999999')
        .padding({ left: 16, top: 10, bottom: 10 })
        .width('100%')
        .textAlign(TextAlign.Start)
        .backgroundColor(Color.White)
      
      // 章节列表
      Scroll(this.scroller) {
        Column() {
          ForEach(this.data, (item: menu) => {
            Row() {
              Column() {
                Row() {
                  Image(item.cover)
                    .width(130)
                    .height(80)
                    .borderRadius(8)
                }.margin({ right: 15 })
              }.width("40%")

              Column() {
                // 章节标题
                Text(item.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .maxLines(1)
                  .width('100%')
                  .textAlign(TextAlign.Start)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                
                // 更新时间
                Text(this.getTimeFn(item.updatetime))
                  .fontSize(16)
                  .fontColor('#999999')
                  .width('100%')
                  .margin({ top: 12 })
                  .textAlign(TextAlign.Start)
              }
              .width("60%")
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.Center)
            }
            .width("95%")
            .padding({ top: 15, bottom: 15 })
            .margin({ top: 12 })
            .backgroundColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              router.pushUrl({
                url: "pages/ShowChapter",
                params: {
                  id: item.id,
                  Bid: this.Bid
                }
              })
            })
          })
        }
        .width('100%')
        .padding({ bottom: 20 })
      }
      .width("100%")
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}