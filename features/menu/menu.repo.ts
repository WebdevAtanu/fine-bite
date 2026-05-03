import db from "@/lib/knex";
import { MenuInterface } from "./menu.interface";
import { randomUUID } from "crypto";

class menuRepo {
  async getAll() {
    return await db("m_menu")
      .where("isActive", true)
      .orderByRaw(
        `
      CASE 
        WHEN type = 'default' THEN 0
        WHEN type = 'master' THEN 1
        WHEN type = 'transaction' THEN 2
        WHEN type = 'report' THEN 3
        ELSE 4
      END
    `,
      )
      .orderByRaw("LOWER(menuName) ASC");
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
        type: menu.type,
        isActive: menu.isActive ?? true,
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
