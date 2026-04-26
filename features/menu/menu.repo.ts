import db from "@/lib/knex";
import { MenuInterface } from "./menu.interface";
import { randomUUID } from "crypto";

class menuRepo {
  async getAll() {
    const result = await db("m_menu").select("*"); // get all menus
    return result;
  }

  async getMenuByName(name: string) {
    const result = await db("m_menu").where("menuName", name).select("*"); // get menu by menu name
    return result;
  }

  async createMenu(menu: MenuInterface) {
    const id = randomUUID(); // generate a unique id
    console.log(id);
    const result = await db("m_menu")
      .insert({
        menuId: id,
        menuName: menu.menuName,
        menuIcon: menu.menuIcon,
        isActive: menu.isActive ?? true,
        createdDate: new Date(),
      })
      .returning("menuId"); // return the inserted id

    return {
      data: result[0],
      message: "Menu created",
    };
  }
}

const menuRepoInstance = new menuRepo(); // create an instance
export { menuRepoInstance as menuRepo }; // export the instance
