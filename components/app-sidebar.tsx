"use client";

import {
    Sidebar,
    SidebarContent,
    SidebarGroup,
    SidebarGroupContent,
    SidebarMenu,
    SidebarMenuItem,
    SidebarMenuButton,
} from "@/components/ui/sidebar";

import * as Icons from "lucide-react";
import { LucideIcon, ChevronRight } from "lucide-react";
import { MenuInterface, MenuGroupedType } from "@/features/menu/menu.interface";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useState } from "react";

function MenuItems({ menu }: { menu: MenuInterface }) {
    const Icon = (Icons[menu.menuIcon as keyof typeof Icons] as LucideIcon) || Icons.SquareMenu;

    const capitalize = (str: string) => {
        if (!str) return "";
        return str.charAt(0).toUpperCase() + str.slice(1);
    };

    const pathName = usePathname();
    const segments = pathName.split("/").filter(Boolean);
    const lastSegment = segments[1];
    const active = lastSegment === menu.menuName;

    return (
        <SidebarMenuItem>
            <SidebarMenuButton asChild>
                <Link
                    href={`/dashboard/${menu.menuName}`}
                    className={`flex items-center px-2 py-1 rounded-md ${active ? "bg-slate-900 hover:bg-slate-900 hover:text-white text-white font-semibold" : ""
                        }`}
                >
                    <Icon className="mr-2 h-4 w-4" />
                    {capitalize(menu.menuName)}
                </Link>
            </SidebarMenuButton>
        </SidebarMenuItem>
    );
}

type Props = {
    menus: MenuGroupedType;
};

export function AppSidebar({ menus }: Props) {
    const pathName = usePathname();
    const segments = pathName.split("/").filter(Boolean);
    const currentMenu = segments[1];

    // track open groups
    const [openGroups, setOpenGroups] = useState<Record<string, boolean>>({});

    const toggleGroup = (type: string) => {
        setOpenGroups((prev) => ({
            ...prev,
            [type]: !prev[type],
        }));
    };

    return (
        <Sidebar>
            <SidebarContent>
                {Object.entries(menus).map(([type, menuList]) => {

                    const isDefault = type.toLowerCase() === "default";

                    // auto-open if current route belongs to this group
                    const isActiveGroup = menuList.some(
                        (m) => m.menuName === currentMenu
                    );

                    const isOpen = isDefault
                        ? true
                        : openGroups[type] ?? isActiveGroup;

                    return (
                        <SidebarGroup key={type} className="">

                            {/* Accordion Header */}
                            <div
                                onClick={() => !isDefault && toggleGroup(type)}
                                className={`flex items-center justify-between px-2 py-1 text-xs uppercase text-gray-500 rounded-md ${!isDefault ? "cursor-pointer hover:bg-gray-100 rounded-none py-2" : ""}`}>
                                <span>{type}</span>

                                {/* Hide arrow for default */}
                                {!isDefault && (
                                    <ChevronRight
                                        className={`h-4 w-4 transition-transform ${isOpen ? "rotate-90" : ""
                                            }`}
                                    />
                                )}
                            </div>

                            {/* Accordion Content */}
                            {isOpen && (
                                <SidebarGroupContent>
                                    <SidebarMenu>
                                        {menuList.map((menu) => (
                                            <MenuItems key={menu.menuId} menu={menu} />
                                        ))}
                                    </SidebarMenu>
                                </SidebarGroupContent>
                            )}
                        </SidebarGroup>
                    );
                })}
            </SidebarContent>
        </Sidebar>
    );
}

// ================================== old code - flat sidebar ===================================
// "use client";

// import {
//     Sidebar,
//     SidebarContent,
//     SidebarGroup,
//     SidebarGroupContent,
//     SidebarGroupLabel,
//     SidebarMenu,
//     SidebarMenuItem,
//     SidebarMenuButton,
// } from "@/components/ui/sidebar";
// // import { Spinner } from "./ui/spinner";
// import * as Icons from "lucide-react";
// import { LucideIcon } from "lucide-react";
// import { MenuInterface, MenuGroupedType } from "@/features/menu/menu.interface";
// import Link from "next/link";
// import { usePathname } from "next/navigation";

// function MenuItems({ menu }: { menu: MenuInterface }) {

//     const Icon =
//         Icons[menu.menuIcon as keyof typeof Icons] as LucideIcon || Icons.SquareMenu; // fallback icon

//     const capitalize = (str: string) => {
//         if (!str) return "";
//         return str.charAt(0).toUpperCase() + str.slice(1);
//     };

//     const pathName = usePathname();
//     const segments = pathName.split("/").filter(Boolean); // for example ['dashboard', 'user']
//     const lastSegment = segments[1]; // take second segment (dashboard/user)
//     const active = lastSegment === `${menu.menuName}`;

//     return (
//         <SidebarMenuItem>
//             <SidebarMenuButton asChild>
//                 <Link href={menu.menuName} className={`${active ? "bg-gray-300" : ""}`}>
//                     {<Icon className="mr-2 h-4 w-4" />}
//                     {capitalize(menu.menuName)}
//                 </Link>
//             </SidebarMenuButton>
//         </SidebarMenuItem>
//     );
// }

// type Props = {
//     menus: MenuGroupedType;
// };

// export function AppSidebar({ menus }: Props) {
//     return (
//         <Sidebar>
//             <SidebarContent>

//                 {Object.entries(menus).map(([type, menuList]) => (
//                     <SidebarGroup key={type}>

//                         {/* Group Label (Separator Title) */}
//                         <SidebarGroupLabel className="uppercase text-xs text-gray-500">
//                             {type}
//                         </SidebarGroupLabel>

//                         <SidebarGroupContent>
//                             <SidebarMenu>
//                                 {menuList.map((menu) => (
//                                     <MenuItems key={menu.menuId} menu={menu} />
//                                 ))}
//                             </SidebarMenu>
//                         </SidebarGroupContent>

//                     </SidebarGroup>
//                 ))}

//             </SidebarContent>
//         </Sidebar>
//     );
// }
