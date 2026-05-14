import { SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar"
import { AppSidebar } from "@/components/app-sidebar"
import { MenuGroupedType } from "@/features/menu/menu.interface";
import { serverGet } from "@/lib/apiServer";
import { ApiResponseType } from "@/types/apiResponse";

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {

  const res = await serverGet<ApiResponseType<MenuGroupedType>>("/api/menu");
  const menus = res.data;

  return (
    <SidebarProvider>
      <AppSidebar menus={menus} />
      <SidebarTrigger />
      <div className="w-full min-h-screen p-4">
        {children}
      </div>
    </SidebarProvider>
  );
}
