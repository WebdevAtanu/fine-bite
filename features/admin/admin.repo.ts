import db from "@/lib/knex";
import { AdminInterface } from "./admin.interface";
import { randomUUID } from "crypto";

class adminRepo {
  async getAll() {
    const result = await db("admin").select("*"); // get all admins
    return result;
  }

  async getAdminById(id: string) {
    const result = await db("admin").where("adminId", id).select("*"); // get admin by id
    return result;
  }

  async getAdminByEmail(email: string) {
    const result = await db("admin").where("email", email).select("*"); // get admin by email
    return result;
  }

  async createAdmin(admin: AdminInterface) {
    const id = randomUUID(); // generate a unique id
    console.log(id);
    const result = await db("admin")
      .insert({
        adminId: id,
        adminName: admin.adminName,
        email: admin.email,
        mobile: admin.mobile,
        password: admin.password,
        isActive: admin.isActive,
        createdDate: new Date(),
      })
      .returning("adminId"); // return the inserted id

    return {
      data: result[0],
      message: "Admin created",
    };
  }
}

const adminRepoInstance = new adminRepo(); // create an instance
export { adminRepoInstance as adminRepo }; // export the instance
