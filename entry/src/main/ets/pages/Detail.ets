// import router from '@ohos.router'
import { router } from '@kit.ArkUI';
import { getBookShow, getComment } from "../../api/request"
import { info, chapterlist2, comment } from "../../common/iface"
import { FavoriteManager, FavoriteBook } from '../../common/FavoriteManager';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Detail {
  private scroller: Scroller = new Scroller()
  @State paramsFrom: object = router.getParams()
  @State Id: number = this.paramsFrom?.['id']
  @State isFavorite: boolean = false
  @State data: info = {
    author: "",
    title: "",
    tag: "",
    info: "",
    pic: "",
    vip: 0,
    bigpic: "",
    lastchapter: "",
    look: "",
    num_comment:0,
    num_look:0,
    num_fav:0,
    updatetime:0,
    chapterlist2: []
  }
  @State comment: Array<comment> = []

  // 检查当前漫画是否已收藏
  async checkIsFavorite() {
    this.isFavorite = await FavoriteManager.isFavorite(this.Id);
  }
  
  // 收藏/取消收藏
  async toggleFavorite() {
    if (this.isFavorite) {
      // 取消收藏
      const success = await FavoriteManager.removeFavorite(this.Id);
      if (success) {
        this.isFavorite = false;
        promptAction.showToast({
          message: '已取消收藏',
          duration: 2000,
        });
      }
    } else {
      // 添加收藏
      const book: FavoriteBook = {
        id: this.Id,
        title: this.data.title,
        cover: this.data.pic,
        author: this.data.author,
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
    console.log(`漫画id：${this.Id}`)
    await getBookShow({ id: this.Id }).then(
      (content) => {
        let str: string = (content.result + "") as string;
        let obj = JSON.parse(str).data as object;
        // console.log(JSON.stringify(obj))
        let data = obj as info
        // console.log(JSON.stringify(data))
        this.data = data
        // console.log(`${this.data.vip}`)
      }
    )

    await getComment({ did: this.Id }).then(
      (content) => {
        let str: string = (content.result + "") as string;
        let obj = JSON.parse(str).data as object;
        let comment = obj as Array<comment>
        this.comment = comment
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

  getForm(str: string) {
    if (str) {
      let str1 = str.slice(1, -1);
      return str1
    } else {
      return false
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        
        Text("漫画详情")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        
        Image(this.isFavorite ? $r('app.media.collection_1') : $r('app.media.collection'))
          .width(24)
          .height(24)
          .onClick(() => {
            this.toggleFavorite()
          })
      }
      .width("100%")
      .height(48)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 16, right: 16 })
      
      Scroll(this.scroller) {
        Column() {
          Row() {
            Image(this.data.bigpic).width("100%")
          }

          Row() {
            Row(){
              Text(this.data.title).fontSize(25).fontWeight(FontWeight.Bold)
              Text(this.data.author).fontSize(18)
            }.width("100%").margin({top:10}).justifyContent(FlexAlign.SpaceBetween)
          }.width("100%")

          Row(){
            Text(`阅读量:${this.data.num_look}  |  收藏量:${this.data.num_fav}  |  评论量:${this.data.num_comment}`).fontSize(15)
          }.width("100%").margin({top:10})

          Row() {
            Text(this.data.info).fontSize(15).maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }.margin({ top: 10 }).width("100%")

          Row() {
            Text(`最新章节:${this.data.lastchapter}`).fontSize(15).fontColor("#ccc")
            Text(this.getTimeFn(this.data.updatetime)).fontColor("#ccc")
          }.margin({ top: 10 }).width("100%").justifyContent(FlexAlign.SpaceBetween)
          .onClick(()=>{
            // console.log("Bid==>"+this.Id)
            router.pushUrl({
              url: "pages/BMenu",
              params:{
                Bid:this.Id
              }
            })
          })

          Scroll(this.scroller) {
            Row() {
              ForEach(this.data.chapterlist2, (item: chapterlist2) => {
                Column() {
                  Row() {
                    Image(item.cover).width("100%")
                  }

                  Row() {
                    Text(item.name)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                  }.margin({top:5})
                }.width("35%").margin({ right: 10 })
              })
            }
          }
          .width("100%")
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.On) // 滚动条常驻显示
          .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
          .scrollBarWidth(10) // 滚动条宽度
          .edgeEffect(EdgeEffect.None)
          .margin({ top: 10 })

          Row() {
            Text("评论").fontSize(20)
          }.width("100%").margin({ top: 10 })

          Column() {
            ForEach(this.comment, (item: comment) => {
              Row() {
                Column() {
                  Image(item.uhead).width("100%").borderRadius(50)
                }.width("30%").margin({ right: 20 })

                Column() {
                  Row() {
                    Text(item.uname).width("100%")
                  }.margin({ top: 10 })

                  Row() {
                    Text(`${this.getTimeFn(item.ctime)}`)
                    Text(`${this.getForm(item.from)}`).margin({ right: 20 })
                  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ top: 10 })

                  Row() {
                    Text(item.content).maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                  }.width('100%').margin({ top: 10 })
                }.width("65%")
              }
              .padding({ top: 10, bottom: 10 })
              .border({
                width: { bottom: 1 },
                color: { bottom: "#cccccc" },
                style: BorderStyle.Solid
              })
            })
          }.margin({ top: 10 })
        }

      }
      .width("100%")
      .scrollable(ScrollDirection.Vertical) // 滚动方向：水平
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Transparent) // 滚动条颜色  (Transparent: 透明)
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .height("82%")
      .align(Alignment.Top)

      Row(){
        Text(`${this.data.chapterlist2[0]?.name}`)
        Text("立即阅读").backgroundColor("#39b4ce").padding(10).borderRadius(10).fontColor("#fff")
          .onClick(()=>{
            console.log(`章节id:${this.data.chapterlist2[0]?.id}`)
            router.pushUrl({
              url: "pages/ShowChapter",
              params:{
                id:this.data.chapterlist2[0]?.id,
                Bid:this.Id
              }
            })
          })
      }.height("10%")
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)

    }.padding({ left: 10, right: 10 })
  }
}