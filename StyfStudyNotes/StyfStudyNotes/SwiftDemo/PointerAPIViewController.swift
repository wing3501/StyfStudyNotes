//
//  PointerAPIViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/3/23.
//  https://juejin.cn/post/7069654422359392292

import UIKit
import MachO

struct TargetClassDescriptor {
    var flags: UInt32
    var parent: UInt32
    var name: Int32
    var accessFunctionPointer: Int32
    var fieldDescriptor: Int32
    var superClassType: Int32
    var metadataNegativeSizeInWords: UInt32
    var metadataPositiveSizeInWords: UInt32
    var numImmediateMembers: UInt32
    var numFields: UInt32
    var fieldOffsetVectorOffset: UInt32
    var Offset: UInt32
    var size: UInt32
}

class LGTeacher {
    var age: Int = 18
    var name: String = "FY"
    
    func say(_ someThing: String) {
        print("say \(someThing)")
    }
    
    @objc dynamic func speak(_ someThing: String) {
        print("speak \(someThing)")
    }
}

class PointerAPIViewController: UIViewController {

    
    func machoTest(){
        //指针读取Macho中的属性名称
        var size: UInt = 0
        var ptr = getsectdata("__TEXT","__swift5_types", &size)
        //获取当前程序运行的地址
        //得到Macho header的基地址
        
//        如果使用了真机运行这段代码，在iOS15的系统中读取出来的地址，和通过image lsit 的lldb指定读取的第三个是一致的。所以你需要改成代码_dyld_get_image_header(3)。
//        var mhHeaderPtr = _dyld_get_image_header(3)
        
        var mhHeaderPtr: UnsafePointer<mach_header>?
        let count = _dyld_image_count()
        for i in 0..<count{
            let excute_header = _dyld_get_image_header(i)
            if excute_header!.pointee.filetype == MH_EXECUTE {
                mhHeaderPtr = excute_header
            }
        }
        
        //获取
        var setCommon64Ptr = getsegbyname("__LINKEDIT")
        //计算当前链接的基地址
        var linkBaseAddress: UInt64 = 0
        if let vmaddr = setCommon64Ptr?.pointee.vmaddr, let fileOff = setCommon64Ptr?.pointee.fileoff{
            linkBaseAddress = vmaddr - fileOff
        }
        
        //内存地址转换成UInt64位置
        var offset: UInt64 = 0
        if let unwrappedPtr = ptr{
            let intRepresentation = UInt64(bitPattern: Int64(Int(bitPattern: unwrappedPtr)))
            offset = intRepresentation - linkBaseAddress
            print(offset)
        }
        
        //DataLo的内存地址
        //将当前程序运行的首地址转成UInt64，便于后续计算
        let mhHeaderPtr_IntRepresentation = UInt64(bitPattern: Int64(Int(bitPattern: mhHeaderPtr)))
        var dataLoAddress = mhHeaderPtr_IntRepresentation + offset

        var dataLoAddressPtr = withUnsafePointer(to: &dataLoAddress) {
            return $0
        }

        var dataLoContent = UnsafePointer<UInt32>.init(bitPattern: Int(exactly: dataLoAddress) ?? 0)?.pointee
        print(dataLoContent)

        let typeDescOffset = UInt64(dataLoContent!) + offset - linkBaseAddress

        var typeDecAddress = typeDescOffset + mhHeaderPtr_IntRepresentation

        let classDesriptor = UnsafePointer<TargetClassDescriptor>.init(bitPattern: Int(exactly: typeDecAddress) ?? 0)?.pointee

        if let name = classDesriptor?.name {
            let nameOffset = Int64(name) + Int64(typeDescOffset) + 8
            print(nameOffset)
            let nameAddress = nameOffset + Int64(mhHeaderPtr_IntRepresentation)
            print(nameAddress)
            if let cChar = UnsafePointer<CChar>.init(bitPattern: Int(nameAddress)){
                print(String(cString: cChar))
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
//        #warning("不知道为什么，计算出来的文件偏移少了0xC000,导致出错")
//        machoTest()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
