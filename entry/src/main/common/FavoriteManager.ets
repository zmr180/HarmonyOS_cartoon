import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

export interface FavoriteBook {
  id: number;
  title: string;
  cover: string;
  author?: string;
  updateTime?: number;
}

// 定义返回数据的接口
export interface FavoriteData {
  books: FavoriteBook[];
}

export class FavoriteManager {
  // 获取Preferences实例
  private static async getPreferences() {
    const context = getContext() as common.UIAbilityContext;
    return await dataPreferences.getPreferences(context, 'favorite_storage');
  }

  // 获取所有收藏
  public static async getAllFavorites(): Promise<FavoriteBook[]> {
    try {
      const preferences = await FavoriteManager.getPreferences();
      const favoritesJson = await preferences.get('favorite_books', '{"books":[]}');
      const data = JSON.parse(favoritesJson as string) as FavoriteData;
      return data.books || [];
    } catch (error) {
      console.error('获取收藏列表失败:', error);
      return [];
    }
  }

  // 添加收藏
  public static async addFavorite(book: FavoriteBook): Promise<boolean> {
    try {
      const favorites = await FavoriteManager.getAllFavorites();
      // 检查是否已收藏
      if (!favorites.some(item => item.id === book.id)) {
        favorites.push(book);
        const preferences = await FavoriteManager.getPreferences();
        await preferences.put('favorite_books', JSON.stringify({ books: favorites }));
        await preferences.flush();
      }
      return true;
    } catch (error) {
      console.error('收藏失败:', error);
      return false;
    }
  }

  // 删除收藏
  public static async removeFavorite(bookId: number): Promise<boolean> {
    try {
      let favorites = await FavoriteManager.getAllFavorites();
      favorites = favorites.filter(item => item.id !== bookId);
      const preferences = await FavoriteManager.getPreferences();
      await preferences.put('favorite_books', JSON.stringify({ books: favorites }));
      await preferences.flush();
      return true;
    } catch (error) {
      console.error('取消收藏失败:', error);
      return false;
    }
  }

  // 检查是否已收藏
  public static async isFavorite(bookId: number): Promise<boolean> {
    try {
      const favorites = await FavoriteManager.getAllFavorites();
      return favorites.some(item => item.id === bookId);
    } catch (error) {
      console.error('检查收藏状态失败:', error);
      return false;
    }
  }
} 