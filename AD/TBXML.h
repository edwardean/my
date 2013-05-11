// ================================================================================================
//  TBXML.h
//  Fast processing of XML files
//
// ================================================================================================
//  Created by Tom Bradley on 21/10/2009.
//  Version 1.4
//  
//  Copyright (c) 2009 Tom Bradley
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
// ================================================================================================


// ================================================================================================
//  Defines
// ================================================================================================
#define MAX_ELEMENTS 100
#define MAX_ATTRIBUTES 100

#define TBXML_ATTRIBUTE_NAME_START 0
#define TBXML_ATTRIBUTE_NAME_END 1
#define TBXML_ATTRIBUTE_VALUE_START 2
#define TBXML_ATTRIBUTE_VALUE_END 3
#define TBXML_ATTRIBUTE_CDATA_END 4

// ================================================================================================
//  Structures
// ================================================================================================
typedef struct _TBXMLAttribute {
	char * name;//属性名
	char * value;//属性值
	struct _TBXMLAttribute * next;//下一个兄弟属性对象的指针
} TBXMLAttribute;

typedef struct _TBXMLElement {
	char * name;//元素标签名
	char * text;//元素text值
	
	TBXMLAttribute * firstAttribute;//指向第一个属性对象的指针
	
	struct _TBXMLElement * parentElement;//父元素
	
	struct _TBXMLElement * firstChild;//首个子元素
	struct _TBXMLElement * currentChild;//下一个兄弟元素
	
	struct _TBXMLElement * nextSibling;
	struct _TBXMLElement * previousSibling;
	
} TBXMLElement;

typedef struct _TBXMLElementBuffer {//用来缓存TBXMLElement结构体对象，
    //当被使用时, 将新建一个缓存区并连接到前一个上（链表）.这样可以有效的管理Element在内存的创建和回收.
	TBXMLElement * elements;
	struct _TBXMLElementBuffer * next;
	struct _TBXMLElementBuffer * previous;
} TBXMLElementBuffer;

typedef struct _TBXMLAttributeBuffer {//是用来缓存TBXMLAttribute对象的. 当被使用时, 将新建一个缓存区并连接到前一个上（链表）. 这样可以有效的管理Attribute在内存的创建和回收
    TBXMLAttribute * attributes;
	struct _TBXMLAttributeBuffer * next;
	struct _TBXMLAttributeBuffer * previous;
} TBXMLAttributeBuffer;

// ================================================================================================
//  TBXML Public Interface
// ================================================================================================
@interface TBXML : NSObject {
	
@private
	TBXMLElement * rootXMLElement;
	
	TBXMLElementBuffer * currentElementBuffer;
	TBXMLAttributeBuffer * currentAttributeBuffer;
	
	long currentElement;
	long currentAttribute;
	
	char * bytes;
	long bytesLength;
}

@property (nonatomic, readonly) TBXMLElement * rootXMLElement;
#pragma 实例化
+ (id)tbxmlWithURL:(NSURL*)aURL;
+ (id)tbxmlWithXMLString:(NSString*)aXMLString;
+ (id)tbxmlWithXMLData:(NSData*)aData;

+ (id)tbxmlWithXMLFile:(NSString*)aXMLFile;//用xml文件名（包括扩展名）实例化一个tbxml对象，例如：TBXML * tbxml = [[TBXML alloc] initWithXMLFile:@"books.xml"];

+ (id)tbxmlWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension;//用xml文件名和扩展名实例化一个tbxml对象
 //例如：TBXML * tbxml = [[TBXML alloc] initWithXMLFile:@"books" fileExtension:@"xml"];

- (id)initWithURL:(NSURL*)aURL;//用一个URL来实例化一个tbxml
//例如：tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:@"http://www.ifanr.com/feed"]];

- (id)initWithXMLString:(NSString*)aXMLString;//用一段xml内容代码来实例化一个tbxml对象
  //例 如：tbxml = [[TBXML alloc] initWithXMLString:@"<root><elem1 attribute1=\"elem1 attribute1\"/><elem2 attribute2=\"elem2 attribute2\"/></root>;"];

- (id)initWithXMLData:(NSData*)aData;//用一个封装了xml内容的NSData对象来实例化tbxml对象
    //例如：TBXML * tbxml = [[TBXML alloc] initWithXMLData:myXMLData];

- (id)initWithXMLFile:(NSString*)aXMLFile;
- (id)initWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension;

@end

// ================================================================================================
//  TBXML Static Functions Interface
// ================================================================================================

@interface TBXML (StaticFunctions)
# pragma 成员方法
+ (NSString*) elementName:(TBXMLElement*)aXMLElement;//返回元素aXMLElement的标签名
//例如：NSString * elementName = [TBXML elementName:element];

+ (NSString*) textForElement:(TBXMLElement*)aXMLElement;//返回元素aXMLElement的text值
//例如：NSString * bookDescription = [TBXML textForElement:bookElement];

+ (NSString*) valueOfAttributeNamed:(NSString *)aName forElement:(TBXMLElement*)aXMLElement;//返回aXMLElement元素中，名为aName的属性的属性值。
//例如：NSString * authorName = [TBXML valueOfAttributeNamed:@"name" forElement:authorElement];


+ (NSString*) attributeName:(TBXMLAttribute*)aXMLAttribute;//返回属性aXMLAttribute的属性名
//例如：NSString * attributeName = [TBXML attributeName:attribute];

+ (NSString*) attributeValue:(TBXMLAttribute*)aXMLAttribute;//返回属性aXMLAttribute的属性值
//例如：NSString * attributeValue = [TBXML attributeValue:attribute];

+ (TBXMLElement*) nextSiblingNamed:(NSString*)aName searchFromElement:(TBXMLElement*)aXMLElement;//返回下一个名为aName的兄弟元素
//例如：TBXMLElement * author = [TBXML nextSiblingNamed:@"author" searchFromElement:author];

+ (TBXMLElement*) childElementNamed:(NSString*)aName parentElement:(TBXMLElement*)aParentXMLElement;//获得aParentXMLElement元素的首个名字为aName的元素
//例如：TBXMLElement * author = [TBXML childElementNamed:@"author" parentElement:rootXMLElement];

@end
