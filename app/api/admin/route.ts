import { adminService } from "@/features/admin/admin.service";
import * as responseHelper from "@/lib/responseHelper";

export async function GET() {
  const admins = await adminService.getAll();
  if (admins.length > 0) {
    return responseHelper.successResponse(admins, "Admins found");
  }
  return responseHelper.successNoData("Admins not found");
}
