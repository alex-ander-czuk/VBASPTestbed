<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="VBASPTestbed._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h2>VB ASP Testbed ...</h2>
    <div class="row">
        <div class="col-md-3">
            <label for="txtDate1" class="control-label col-sm-3 input-sm">Date 1</label>
            <asp:TextBox id="txtDate1" enabled="true" CssClass="form-control input-sm" runat="server" onblur="check_date(this, -365,)" AutoPostBack="false" autocomplete="off"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <label for="txtDate2" class="control-label col-sm-3 input-sm">Date 2</label>
            <asp:TextBox id="txtDate2" enabled="true" CssClass="form-control input-sm" runat="server" AutoPostBack="false" autocomplete="off"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <label for="txtDate3" class="control-label col-sm-3 input-sm">Date 3</label>
            <asp:TextBox id="txtDate3" enabled="true" CssClass="form-control input-sm" runat="server" onblur="focus_on_first()" AutoPostBack="false" autocomplete="off"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <label for="txtDate4" class="control-label col-sm-3 input-sm">Date 4</label>
            <asp:TextBox id="txtDate4" enabled="true" CssClass="form-control input-sm" runat="server" AutoPostBack="false" autocomplete="off"></asp:TextBox>
        </div>
        <%--<div class="col-md-3">
            <asp:TextBox id="txtDate2" enabled="true" placeholder="Date 2" CssClass="form-control input-sm" runat="server" AutoPostBack="false" autocomplete="off"></asp:TextBox>
        </div>--%>
        <%--<div class="col-md-3">
            <asp:Button runat="server" ID="btnGo" class="btn btn-default btn-block input-sm" autopostback="false" text="Check Date" />
        </div>--%>
    </div>

    <script type="text/javascript">

        function focus_on_first() {
            console.log('In focus_on_first');
            //document.getElementById("MainContent_txtDate1").focus();
            $("#MainContent_txtDate1").focus();
            console.log('After the focus command');
        }

        function check_date(textbox, age_check, check_against, check_type) {

            console.log('textbox       = ' + textbox.id);
            console.log('age_check     = ' + age_check);
            console.log('check_against = ' + check_against);
            console.log('check_ytpe    = ' + check_type);

            var error_text = '';
            var v_date = textbox.value;
            var v_year, v_month, v_day;
            var v_checked_date;

            //First check to see if the date is a uk date
            console.log('Checking ' + v_date + ' is a real UK date');
            var slashes = (v_date.match(new RegExp("/", "g")) || []).length;
            console.log('Number of slashes = ' + slashes);
            if (slashes == 1) {
                console.log('The date could be a 2 part date');
                v_year = luxon.DateTime.local().year; //Get the year
                console.log('Setting year to ' + v_year);
                v_month = v_date.split('/')[1]; //Get the month
                console.log('Month read as ' + v_month);
                v_day = v_date.split('/')[0]; //Get the day
                console.log('Day read as ' + v_day);
                v_checked_date = luxon.DateTime.local(parseInt(v_year), parseInt(v_month), parseInt(v_day));
                console.log('v_checked_date = ' + v_checked_date);
                console.log('v_checked_date.setLocale("en-GB").toLocaleString() = ' + v_checked_date.setLocale('en-GB').toLocaleString());
            }
            else if (slashes == 2) {
                console.log('The date could be a 3 part date')
                v_year = v_date.split('/')[2]; //Get the year
                if (v_year.length == 2) { //Add the millenium if it isnt given
                    v_year = "20" + v_year;
                }
                console.log('Year read as ' + v_year);
                v_month = v_date.split('/')[1]; //Get the month
                console.log('Month read as ' + v_month);
                v_day = v_date.split('/')[0]; //Get the day
                console.log('Day read as ' + v_day);
                v_checked_date = luxon.DateTime.local(parseInt(v_year), parseInt(v_month), parseInt(v_day));
                console.log('v_checked_date = ' + v_checked_date);
                console.log('v_checked_date.setLocale("en-GB").toLocaleString() = ' + v_checked_date.setLocale('en-GB').toLocaleString());
            }
            else {
                console.log('The date is invalid on slash check');
                error_text = 'Date not in correct format, please use the "/" character to separate values.';
            }

            if (isNaN(v_checked_date)) {
                console.log('Date is not valid on NaN check!!!');
                error_text = 'Date not in correct format please use (d)d/(m)m(/(yy)yy.)';
            }

            if (error_text.length > 0) {
                alert(error_text);
                return false;
            }
            else {
                //Check to see if an age check is required
                console.log('Is there an age check...?');
                if (typeof age_check !== 'undefined') {
                    console.log('Yes, perform an age check!');
                    //var v_compare_date = luxon.DateTimeime.local().plus({ days: parseInt(age_check) });
                    var v_compare_date = luxon.DateTime.local().plus({ days: age_check });
                    console.log('v_compare_date = ' + v_compare_date);
                    if (v_checked_date < v_compare_date) {
                        console.log(v_checked_date.setLocale('en-GB').toLocaleString() + ' < ' + v_compare_date.setLocale('en-GB').toLocaleString());
                        console.log('The given date is over a year old');
                        alert('This date is over ' + (0 - parseInt(age_check)) + ' days old!')
                    }
                    else {
                        console.log(v_checked_date.setLocale('en-GB').toLocaleString() + ' > ' + v_compare_date.setLocale('en-GB').toLocaleString());

                    }
                }
                else {
                    console.log('No age check necessary.');
                }
            }
        }
    </script>

</asp:Content>
