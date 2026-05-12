import { AdminInterface, AdminLoginInterface } from "./city.interface";
import { adminRepo } from "./city.repo";
import bcrypt from "bcrypt";
import { generateToken } from "@/lib/jwt";

class adminService {
  async getAll() {
    return await adminRepo.getAll();
  }

  async createAdmin(admin: AdminInterface) {
    const adminExists = await adminRepo.getAdminByEmail(admin.email); // check if admin exists
    if (adminExists != null) {
      return {
        data: null,
        message: "Admin with the email already exists",
      };
    }
    return await adminRepo.createAdmin(admin);
  }

  async loginAdmin(admin: AdminLoginInterface) {
    const adminExists = await adminRepo.getAdminByEmail(admin.email); // check if admin exists

    if (adminExists == null || adminExists == undefined) {
      return {
        data: null,
        message: "Admin not found",
      };
    }

    // check if password is valid
    const isPasswordValid = await bcrypt.compare(
      admin.password,
      adminExists.password,
    );

    if (!isPasswordValid) {
      return {
        data: null,
        message: "Invalid password",
      };
    }

    const token = generateToken(adminExists);

    return {
      data: { admin: adminExists, token },
      message: "Admin logged in",
    };
  }
}

const adminServiceInstance = new adminService(); // create an instance
export { adminServiceInstance as adminService }; // export the instance
