"use client";

import { useState, useEffect } from "react";
import {
    Sidebar,
    SidebarContent,
    SidebarGroup,
    SidebarGroupContent,
    SidebarGroupLabel,
    SidebarMenu,
    SidebarMenuItem,
    SidebarMenuButton,
} from "@/components/ui/sidebar";
// import { Spinner } from "./ui/spinner";
import { Home, Users } from "lucide-react";
import { MenuInterface } from "@/features/menu/menu.interface";
import Link from "next/link";
import { usePathname } from "next/navigation";

function MenuItems({ menu }: { menu: MenuInterface }) {
    const iconMap = {
        home: Home,
        user: Users,
    };

    const Icon = iconMap[menu.menuIcon as keyof typeof iconMap];

    const capitalize = (str: string) => {
        if (!str) return "";
        return str.charAt(0).toUpperCase() + str.slice(1);
    };

    const pathName = usePathname();
    console.log(pathName);
    const active = pathName === `/${menu.menuName}`;

    return (
        <SidebarMenuItem>
            <SidebarMenuButton asChild>
                <Link href={menu.menuName} className={`${active ? "bg-gray-300" : ""}`}>
                    {Icon && <Icon className="mr-2 h-4 w-4" />}
                    {capitalize(menu.menuName)}
                </Link>
            </SidebarMenuButton>
        </SidebarMenuItem>
    );
}

type Props = {
    menus: MenuInterface[];
};

export function AppSidebar({ menus }: Props) {
    // const [hasToken, setHasToken] = useState<boolean | null>(null);

    // useEffect(() => {
    //     const token = localStorage.getItem("token");
    //     setHasToken(!!token);
    // }, []);

    // // ⛔ Prevent hydration mismatch
    // if (hasToken === null) return null;

    // // ❌ No token → hide sidebar
    // if (!hasToken) return null;

    return (
        <Sidebar>
            <SidebarContent>
                <SidebarGroup>
                    <SidebarGroupLabel>My App</SidebarGroupLabel>
                    <SidebarGroupContent>
                        <SidebarMenu>
                            {
                                menus.map((menu) => (
                                    <MenuItems key={menu.menuId} menu={menu} />
                                ))
                            }
                        </SidebarMenu>
                    </SidebarGroupContent>
                </SidebarGroup>
            </SidebarContent>
        </Sidebar>
    );
}