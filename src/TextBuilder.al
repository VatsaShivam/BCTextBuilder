page 50104 "TextBuilder Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Text Builder Page';

    layout
    {
        area(Content)
        {
            group(Personal_Info)
            {
                Caption = 'Personal Info';
                field(customer_id; customer_id)
                {
                    Caption = 'Customer Id';
                }
                field(first_name; first_name)
                {
                    Caption = 'First Name';
                }
                field(last_name; last_name)
                {
                    Caption = 'Last Name';
                }
                field(email; email)
                {
                    Caption = 'Email';
                }
                field(phone; phone)
                {
                    Caption = 'Phone';
                }
                field(state; stateEnum)
                {
                    Caption = 'State';
                }
                field(city; city)
                {
                    Caption = 'City';
                }
                field(zip_code; zip_code)
                {
                    Caption = 'ZIP Code';
                }
                field(country; country)
                {
                    Caption = 'Country';
                }
            }
            group(Order_One)
            {
                Caption = 'Order Info';
                field(order_id; order_id)
                {
                    Caption = 'Order Id';
                }
                field(order_date; order_date)
                {
                    Caption = 'Order Date';
                }
                field(total_amount; total_amount)
                {
                    Caption = 'Total Amount';
                }
                field(product_id; product_id)
                {
                    Caption = 'Product Id';
                }
                field(quantity; quantity)
                {
                    Caption = 'Quantity';
                    trigger OnValidate()
                    var
                        quant: Integer;
                    begin
                        Evaluate(quant, quantity);
                        price := (total_amount / quant);
                        statusEnum := (price > 2000.00) ? statusEnum::Expensive : (price > 1000.00) ? statusEnum::Average : statusEnum::Cheap;
                    end;
                }
                field(price; price)
                {

                    Caption = 'Price';
                    AutoFormatType = 0;
                    DecimalPlaces = 2 : 2;
                }
                field(status; statusEnum)
                {
                    Caption = 'Status';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TernaryOperator)
            {
                Caption = 'Ternary Operator';
                trigger OnAction()
                begin

                    // Ternary Operator
                    status := (price > 2000) ? 'Expensive' : (price > 1000) ? 'Average' : 'Cheap';

                    //despite writing in below way, use ternary
                    if price > 2000 then
                        status := 'Expensive'
                    else if price > 1000 then
                        status := 'Average'
                    else
                        status := 'Cheap'
                end;
            }
        }
        area(Navigation)
        {
            group(TextBuilder)
            {
                action(XML)
                {
                    Caption = 'XML FORMAT';
                    Image = XMLFile;
                    trigger OnAction()
                    var
                        TextBuilder: TextBuilder;
                    begin
                        TextBuilder.AppendLine('<customer>');
                        TextBuilder.AppendLine('    <id>' + customer_id + '</id>');
                        TextBuilder.AppendLine('    <first name>' + first_name + '</first name>');
                        TextBuilder.AppendLine('    <last name>' + last_name + '</last name>');
                        TextBuilder.AppendLine('    <name>' + first_name + ' ' + last_name + '</name>');
                        TextBuilder.AppendLine('    <email>' + email + '</email>');
                        TextBuilder.AppendLine('    <phone>' + phone + '</phone>');
                        TextBuilder.AppendLine('    <state>' + format(stateEnum) + '</state>');
                        TextBuilder.AppendLine('    <city>' + city + '</city>');
                        TextBuilder.AppendLine('    <zip code>' + zip_code + '</zip code>');
                        TextBuilder.AppendLine('    <country>' + country + '</country>');
                        TextBuilder.AppendLine('</customer>');
                        TextBuilder.AppendLine('<order>');
                        TextBuilder.AppendLine('    <order id>' + order_id + '</order id>');
                        TextBuilder.AppendLine('    <order date>' + Format(order_date) + '</order date>');
                        TextBuilder.AppendLine('    <total amount>' + Format(total_amount) + '</total amount>');
                        TextBuilder.AppendLine('    <product>');
                        TextBuilder.AppendLine('        <product id>' + product_id + '</product id>');
                        TextBuilder.AppendLine('        <quantity>' + quantity + '</quantity>');
                        TextBuilder.AppendLine('        <price>' + Format(price, 0, '<Precision,2:2><Standard Format,2>') + '</price>');
                        TextBuilder.AppendLine('        <status>' + Format(statusEnum) + '</status>');
                        TextBuilder.AppendLine('    </product>');
                        TextBuilder.AppendLine('</order>');
                        Message('%1', TextBuilder.ToText());
                    end;
                }
                action(Json)
                {
                    Caption = 'JSON FORMAT';
                    Image = Filed;
                    trigger OnAction()
                    var
                        TextBuilder: TextBuilder;
                    begin
                        TextBuilder.AppendLine('"customer"');
                        TextBuilder.AppendLine('{');
                        TextBuilder.AppendLine('    "id": ' + customer_id + ',');
                        TextBuilder.AppendLine('    "first name": ' + first_name + ',');
                        TextBuilder.AppendLine('    "last name": ' + last_name + ',');
                        TextBuilder.AppendLine('    "name": ' + first_name + ' ' + last_name + ',');
                        TextBuilder.AppendLine('    "email": ' + email + ',');
                        TextBuilder.AppendLine('    "phone": ' + phone + ',');
                        TextBuilder.AppendLine('    "state": ' + Format(stateEnum) + ',');
                        TextBuilder.AppendLine('    "city": ' + city + ',');
                        TextBuilder.AppendLine('    "zip code": ' + zip_code + ',');
                        TextBuilder.AppendLine('    "country": ' + country + ',');
                        TextBuilder.AppendLine('},');
                        TextBuilder.AppendLine('"order"');
                        TextBuilder.AppendLine('{');
                        TextBuilder.AppendLine('    "order id": ' + order_id + ',');
                        TextBuilder.AppendLine('    "order date": ' + Format(order_date) + ',');
                        TextBuilder.AppendLine('    "total amount": ' + Format(total_amount) + ',');
                        TextBuilder.AppendLine('    "product" ');
                        TextBuilder.AppendLine('    {');
                        TextBuilder.AppendLine('        "product id": ' + product_id + ',');
                        TextBuilder.AppendLine('        "quantity": ' + quantity + ',');
                        TextBuilder.AppendLine('        "price": ' + Format(price, 0, '<Precision,2:2><Standard Format,2>') + ',');
                        TextBuilder.AppendLine('        "status": ' + Format(statusEnum) + ',');
                        TextBuilder.AppendLine('    }');
                        TextBuilder.AppendLine('}');
                        Message('%1', TextBuilder.ToText());
                    end;
                }
                action(OrderEmail)
                {
                    Caption = 'Order Email';
                    Image = Email;
                    trigger OnAction()
                    var
                        TextBuilder: TextBuilder;
                    begin
                        TextBuilder.AppendLine('Subject: Order Confirmation - #' + order_id);
                        TextBuilder.AppendLine('');
                        TextBuilder.AppendLine('Dear ' + first_name + ',');
                        TextBuilder.AppendLine('Thank you for your order. We are pleased to confirm that your order for #' + product_id + ' has been received and is being processed.');
                        TextBuilder.AppendLine('');
                        TextBuilder.AppendLine('Order Details:');
                        TextBuilder.AppendLine('    - Product: ' + product_id);
                        TextBuilder.AppendLine('    - Quantity: ' + quantity);
                        TextBuilder.AppendLine('    - Expected Delivery Date: ' + Format(CalcDate('5d', Today)));
                        TextBuilder.AppendLine('');
                        TextBuilder.AppendLine('If you have any questions, please feel free to contact us.');
                        TextBuilder.AppendLine('Thank you for choosing us!');
                        TextBuilder.AppendLine('');
                        TextBuilder.AppendLine('Best regards,');
                        TextBuilder.AppendLine('Nirvana');
                        Message('%1', TextBuilder.ToText());
                    end;
                }
                action(CSV)
                {
                    Caption = 'CSV FORMAT';
                    Image = Action;

                    trigger OnAction()
                    var
                        TextBuilder: TextBuilder;
                        CustomOrder: Record "Custom Order";
                        CustomCustomer: Record "Custom Customer";
                        CustomOrderLine: Record "Custom Order Line";
                    begin
                        TextBuilder.Append('CustomerNo,CustomerName,City,Country,Email,OrderId,');
                        TextBuilder.Append('OrderDate,PaymentMethod,ProductId,ProductName,Quantity,TotalPrice,SKU');
                        TextBuilder.AppendLine('');
                        CustomOrder.SetFilter(status, '%1|%2', CustomOrder.status::Confirmed, CustomOrder.Status::Shipped);
                        if CustomOrder.FindSet() then
                            repeat
                                CustomCustomer.SetRange("Customer Id", CustomOrder."Customer Id");
                                if CustomCustomer.FindFirst() then begin
                                    CustomOrderLine.SetRange("Order Id", CustomOrder."Order Id");
                                    if CustomOrderLine.FindSet() then
                                        repeat
                                            TextBuilder.AppendLine(
                                                CustomCustomer."Customer Id" + ',' +
                                                CustomCustomer.Name + ',' +
                                                CustomCustomer.City + ',' +
                                                CustomCustomer.Country + ',' +
                                                CustomCustomer.Email + ',' +
                                                CustomOrder."Order Id" + ',' +
                                                Format(CustomOrder."Order Date") + ',' +
                                                CustomOrder."Payment Method" + ',' +
                                                CustomOrderLine."Product Name" + ',' +
                                                CustomOrderLine."Product Name" + ',' +
                                                Format(CustomOrderLine.Quantity) + ',' +
                                                DelChr(Format(CustomOrderLine."Total Price"), '=', ',') + ',' +
                                                CustomOrderLine.SKU
                                            );
                                        until CustomOrderLine.Next() = 0;
                                end;
                            until CustomOrder.Next() = 0;
                        Message('%1', TextBuilder.ToText());
                    end;
                }

                action(TextBuilderFunction)
                {
                    Caption = 'TextBuilder Function';
                    Image = Check;
                    trigger OnAction()
                    var
                        TxtBuilder: TextBuilder;
                        TextBuilder1: TextBuilder;
                        Txt: Text;
                        NewTxt: Text;
                        OldTxt: Text;
                        StartIndex: Integer;
                        CountIndex: Integer;
                        Ok: Boolean;
                    begin

                        //MaxCapacity of TextBuilder
                        Message('MaxCapacity of Text Builder is: %1', TxtBuilder.MaxCapacity());

                        //Append method in TextBuilder
                        TxtBuilder.Append('Hi, My name is Shivam and I am an ERP Developer.');

                        //Capacity method in TextBuilder
                        Message('Capacity of Text builder is %1', TxtBuilder.Capacity);
                        Txt := ' I am working on AL and SQL.';
                        TxtBuilder.Insert(TxtBuilder.Capacity() + 1, Txt);

                        // ToText() and Length() function in TextBuilder
                        Message('Insert function in TextBuilder:\ NewText is: %1\ Length of TextBuilder: %2\',
                        TxtBuilder.ToText(), TxtBuilder.Length());
                        TxtBuilder.Clear;
                        Message('Text inside the Text builder: %1', TxtBuilder.Length());

                        //EnsureCapacity in TextBuilder
                        TxtBuilder.EnsureCapacity(100);
                        TxtBuilder.Append('Hi Riva, My name is Shivam and I am an ERP Developer.');

                        Message('Capacity of TextBuilder is: %1\ Length of TextBuilder is: %2', TxtBuilder.Capacity(), TxtBuilder.Length());

                        //Replace method in TextBuilder
                        TxtBuilder.Replace('I am an ERP Developer', 'I have something for you');
                        Message('New String:\%1', TxtBuilder);

                        //Remove function in TextBuilder
                        StartIndex := (TxtBuilder.Length() - 18);
                        CountIndex := TxtBuilder.Length() - StartIndex + 1;
                        TxtBuilder.Remove(StartIndex, CountIndex);
                        Message('After removing the text,remaining text are:\%1', TxtBuilder.ToText());

                        //ToText(Integer,Integer) in TextBuilder
                        Message('After removing the text,remaining text from 1 to 26 are:\%1.', TxtBuilder.ToText(1, 26));

                        Txt := 'The sun rose slowly over the quiet town, casting golden light on sleepy streets,' +
                         'while birds sang from lush green trees and early risers walked briskly to work, coffee in hand.';
                        TextBuilder1.Append(Txt);
                        Message('TextBuilder length is: %1', TextBuilder1.Length());

                        // Define the old and new text for replacement
                        OldTxt := 'coffee in hand';
                        NewTxt := 'holding stream cup of coffee';

                        // Find the position of 'coffee in hand'
                        StartIndex := StrPos(TextBuilder1.ToText(), OldTxt);
                        if StartIndex > 0 then begin
                            CountIndex := StrLen(OldTxt);
                            // Replace the specific text
                            Ok := TextBuilder1.Replace(OldTxt, NewTxt, StartIndex, CountIndex);
                            if Ok then
                                Message('After replacing the text:\%1', TextBuilder1.ToText())
                            else
                                Message('Replacement failed.');
                        end else
                            Message('Text to replace not found.');
                    end;
                }
            }
        }
    }

    var
        customer_id, first_name, last_name, email, phone, state, city, zip_code, country, order_id, status, product_id, quantity : Text;

        price, total_amount : Decimal;

        order_date: Date;

        statusEnum: Enum "Status";
        stateEnum: Enum "State";

}