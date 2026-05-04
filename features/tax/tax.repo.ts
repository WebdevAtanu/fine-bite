import db from "@/lib/knex";
import { AdminInterface } from "./admin.interface";
import { randomUUID } from "crypto";
import bcrypt from "bcrypt";

class adminRepo {
  async getAll() {
    // const result = await db("admin").select("*"); // get all admins
    const result = await db.raw(`EXEC sp_admin @flag = :flag`, {
      flag: "SELECT",
    });
    return result;
  }

  async getAdminById(id: string) {
    const result = await db("admin").where("adminId", id).select("*"); // get admin by id
    return result;
  }

  async getAdminByEmail(email: string) {
    // const result = await db("admin").where("email", email).select("*").first(); // get admin by email
    const result = await db.raw(
      `EXEC sp_admin @flag = :flag, @email = :email`,
      {
        flag: "SELECTBYEMAIL",
        email: email,
      },
    );
    return result[0];
  }

  async createAdmin(admin: AdminInterface) {
    const id = randomUUID(); // generate a unique id
    const passwordHash = await bcrypt.hash(admin.password, 10);
    const result = await db("admin")
      .insert({
        adminId: id,
        adminName: admin.adminName,
        email: admin.email,
        mobile: admin.mobile,
        password: passwordHash,
        isActive: admin.isActive ?? true,
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
