import MyBar from "../components/MyBar"
import { router } from '@kit.ArkUI'

@Entry
@Component
struct My {
  scroller: Scroller = new Scroller()
  
  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          // 顶部用户信息
          Row() {
            Image($r('app.media.userpic'))
              .width(80)
              .height(80)
              .borderRadius(40)
            
            Column() {
              Row() {
                Text("游客001")
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                
                Row() {
                  Text("开通")
                    .fontSize(14)
                    .fontColor(Color.White)
                    .backgroundColor('#B0B0B0')
                    .borderRadius(15)
                    .padding({left: 8, right: 8, top: 2, bottom: 2})
                }
                .margin({left: 10})
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
            .margin({left: 15})
          }
          .width('100%')
          .padding({left: 20, right: 20, top: 20, bottom: 20})
          .justifyContent(FlexAlign.Start)
          
          // 虚拟货币信息
          Row() {
            Column() {
              Text("0")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              Text("宝石")
                .fontSize(14)
                .margin({top: 5})
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
            
            Column() {
              Text("0")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              Text("星币")
                .fontSize(14)
                .margin({top: 5})
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
            
            Column() {
              Text("0")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              Text("阅读券")
                .fontSize(14)
                .margin({top: 5})
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
            
            Column() {
              Text("50")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              Text("金币")
                .fontSize(14)
                .margin({top: 5})
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({top: 10, bottom: 20})
          
          // VIP会员与宝石充值卡片
          Row() {
            // VIP会员卡片
            Column() {
              Row() {
                Column() {
                  Text("VIP会员")
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                  Text("畅读全站98%漫画")
                    .fontSize(12)
                    .fontColor(Color.White)
                    .margin({top: 5})
                  
                  Row() {
                    Text("开通")
                      .fontSize(14)
                      .fontColor(Color.Black)
                      .backgroundColor(Color.White)
                      .borderRadius(15)
                      .padding({left: 10, right: 10, top: 4, bottom: 4})
                  }
                  .margin({top: 10})
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
                
                // 使用简单的皇冠图标替代
                Column() {
                  Row() {
                    Text("👑")
                      .fontSize(36)
                  }
                }
              }
              .width('100%')
              .padding(15)
            }
            .layoutWeight(1)
            .height(120)
            .backgroundColor('#FFC557')
            .borderRadius(10)
            .margin({right: 5})
            
            // 宝石充值卡片
            Column() {
              Row() {
                Column() {
                  Text("宝石充值")
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                  Text("最高送1个月VIP")
                    .fontSize(12)
                    .fontColor(Color.White)
                    .margin({top: 5})
                  
                  Row() {
                    Text("充值")
                      .fontSize(14)
                      .fontColor(Color.Black)
                      .backgroundColor(Color.White)
                      .borderRadius(15)
                      .padding({left: 10, right: 10, top: 4, bottom: 4})
                  }
                  .margin({top: 10})
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
                
                // 使用简单的钻石图标替代
                Column() {
                  Row() {
                    Text("💎")
                      .fontSize(36)
                  }
                }
              }
              .width('100%')
              .padding(15)
            }
            .layoutWeight(1)
            .height(120)
            .backgroundColor('#FF7878')
            .borderRadius(10)
            .margin({left: 5})
          }
          .padding({left: 15, right: 15})
          .margin({top: 10, bottom: 10})
          
          // 功能图标栏
          Grid() {
            // 第一行功能图标
            GridItem() {
              Column() {
                Text("📝")
                  .fontSize(24)
                Text("签到")
                  .fontSize(14)
                  .margin({top: 8})
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            
            GridItem() {
              Column() {
                Text("💰")
                  .fontSize(24)
                Text("我的钱包")
                  .fontSize(14)
                  .margin({top: 8})
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            
            GridItem() {
              Column() {
                Text("🎯")
                  .fontSize(24)
                Text("任务中心")
                  .fontSize(14)
                  .margin({top: 8})
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            
            GridItem() {
              Column() {
                Text("📬")
                  .fontSize(24)
                Text("消息")
                  .fontSize(14)
                  .margin({top: 8})
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }

            // 第二行功能图标
            GridItem() {
              Column() {
                Text("⏱️")
                  .fontSize(24)
                Text("抢先看")
                  .fontSize(14)
                  .margin({top: 8})
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            
            GridItem() {
              Column() {
                Text("🎁")
                  .fontSize(24)
                Text("福利中心")
                  .fontSize(14)
                  .margin({top: 8})
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            
            GridItem() {
              Column() {
                Text("📥")
                  .fontSize(24)
                Text("离线缓存")
                  .fontSize(14)
                  .margin({top: 8})
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            
            GridItem() {
              Column() {
                Text("🥚")
                  .fontSize(24)
                Text("孵化室")
                  .fontSize(14)
                  .margin({top: 8})
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .width('100%')
          .height(180)
          .padding({left: 15, right: 15, top: 10, bottom: 10})
          
          // 活动提示横幅
          Row() {
            Text("点我领金币、阅读券，免费看漫画")
              .fontSize(14)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .width('100%')
          }
          .width('90%')
          .height(40)
          .backgroundColor('#FF8383')
          .borderRadius(20)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .margin({top: 5, bottom: 15})
          
          // 活动横幅
          Stack() {
            // 简单替代图片
            Column() {
              Text("免费抽漫画券")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFF00')
                
              Text("释放抢先章节")
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({top: 10})
                
              Row() {
                Text("追更快人一步 · 速抽")
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#4169E1')
                  .borderRadius(15)
                  .padding({left: 10, right: 10, top: 4, bottom: 4})
              }
              .margin({top: 15})
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .width('92%')
          .height(150)
          .backgroundColor('#FF6B81')
          .borderRadius(10)
          .margin({top: 5, bottom: 15})
          
          // 菜单列表
          Column() {
            Row() {
              Text("👤")
                .fontSize(20)
              Text("个性装扮")
                .fontSize(16)
                .margin({left: 15})
              Blank()
              Image($r('app.media.next'))
                .width(18)
                .height(18)
            }
            .width('100%')
            .padding({top: 15, bottom: 15, left: 15, right: 15})
            .justifyContent(FlexAlign.SpaceBetween)
            
            Divider().color('#F0F0F0').height(1).width('92%')
            
            Row() {
              Text("⏰")
                .fontSize(20)
              Text("阅读历史")
                .fontSize(16)
                .margin({left: 15})
              Blank()
              Image($r('app.media.next'))
                .width(18)
                .height(18)
            }
            .width('100%')
            .padding({top: 15, bottom: 15, left: 15, right: 15})
            .justifyContent(FlexAlign.SpaceBetween)
            
            Divider().color('#F0F0F0').height(1).width('92%')
            
            Row() {
              Text("🎟️")
                .fontSize(20)
              Text("兑换码")
                .fontSize(16)
                .margin({left: 15})
              Blank()
              Image($r('app.media.next'))
                .width(18)
                .height(18)
            }
            .width('100%')
            .padding({top: 15, bottom: 15, left: 15, right: 15})
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .margin({top: 10, bottom: 20})
        }
      }
      .width('100%')
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
      .height('90%')
      .backgroundColor('#F5F5F5')
      
      // 底部导航栏
      MyBar({ n: 3 })
        .height('10%')
    }
    .width('100%')
    .height('100%')
  }
}