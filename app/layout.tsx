import type { Metadata } from "next";
import "./globals.css";
import { SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar"
import { AppSidebar } from "@/components/app-sidebar"

export const metadata: Metadata = {
  title: "Restro",
  description: "Restro",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="">
      <body className="min-h-full flex flex-col">
        <SidebarProvider>
          <AppSidebar />
          <SidebarTrigger />{children}
        </SidebarProvider>
      </body>
    </html>
  );
}
