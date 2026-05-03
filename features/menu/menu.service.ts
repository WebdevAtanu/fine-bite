import { MenuInterface } from "./menu.interface";
import { menuRepo } from "./menu.repo";

class menuService {
  async getAll() {
    const menus = await menuRepo.getAll();

    const groupedMenu = menus.reduce(
      (acc, menu) => {
        if (!acc[menu.type]) {
          acc[menu.type] = [];
        }
        acc[menu.type].push(menu);
        return acc;
      },
      {} as Record<string, MenuInterface[]>,
    );

    return groupedMenu;
  }

  async createMenu(menu: MenuInterface) {
    const menuExists = await menuRepo.getMenuByName(menu.menuName); // check if menu exists
    if (menuExists.length > 0) {
      return {
        data: null,
        message: "Menu with the name already exists",
      };
    }
    return await menuRepo.createMenu(menu);
  }
}

const menuServiceInstance = new menuService(); // create an instance
export { menuServiceInstance as menuService }; // export the instance
