import { MenuInterface } from "./menu.interface";
import { menuRepo } from "./menu.repo";

class menuService {
  async getAll() {
    return await menuRepo.getAll();
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
