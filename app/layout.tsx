import type { Metadata } from "next";
import "./globals.css";
import { SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar"
import { AppSidebar } from "@/components/app-sidebar"
import { MenuInterface } from "@/features/menu/menu.interface";
import { serverGet } from "@/lib/apiServer";
import { ApiResponseType } from "@/types/apiResponse";
import { Toaster } from "react-hot-toast";

export const metadata: Metadata = {
  title: "Restro",
  description: "Restro",
};

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {

  const res = await serverGet<ApiResponseType<MenuInterface[]>>("/api/menu");
  const menus = res.data;

  return (
    <html lang="en" className="">
      <body className="min-h-full flex flex-col">
        <Toaster position="top-right"/>
        <SidebarProvider>
          <AppSidebar menus={menus} />
          <SidebarTrigger />{children}
        </SidebarProvider>
      </body>
    </html>
  );
}
