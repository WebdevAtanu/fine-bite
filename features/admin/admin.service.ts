import { AdminInterface } from "./admin.interface";
import { adminRepo } from "./admin.repo";

class adminService {
  async getAll() {
    return await adminRepo.getAll();
  }

  async createAdmin(admin: AdminInterface) {
    const adminExists = await adminRepo.getAdminByEmail(admin.email); // check if admin exists
    if (adminExists.length > 0) {
      return {
        data: null,
        message: "Admin with the email already exists",
      };
    }
    return await adminRepo.createAdmin(admin);
  }
}

const adminServiceInstance = new adminService(); // create an instance
export { adminServiceInstance as adminService }; // export the instance
