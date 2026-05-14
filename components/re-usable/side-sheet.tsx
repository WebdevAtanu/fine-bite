import React from 'react'
import {
    Sheet,
    SheetContent,
    SheetDescription,
    SheetHeader,
    SheetTitle,
    SheetTrigger,
} from "@/components/ui/sheet"

type SideSheetPropType = {
    title: string;
    description: string;
    trigger: React.ReactNode;
    children: React.ReactNode;
};

function SideSheet({
    title,
    description,
    trigger,
    children,
}: SideSheetPropType) {
    return (
        <Sheet>
            <SheetTrigger asChild>
                {trigger}
            </SheetTrigger>

            <SheetContent>
                <SheetHeader>
                    <SheetTitle>{title}</SheetTitle>
                    <SheetDescription>{description}</SheetDescription>
                </SheetHeader>

                <div className='px-4'>
                    {children}
                </div>
            </SheetContent>
        </Sheet>
    )
}

export default SideSheet