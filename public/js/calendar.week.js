(function(a) {
    var calendarWeek = function (c) {
        var b = !1;

        function d(a) {
            a = new Date(a);
            var b = a.getFullYear()
                , c = a.getMonth()
                , d = c + 1
                , e = a.getDate()
                , f = a.getDay();
            return h.params.dateFormat.replace(/yyyy/g, b).replace(/yy/g, (b + "").substring(2)).replace(/mm/g, 10 > d ? "0" + d : d).replace(/m/g, d).replace(/MM/g, h.params.monthNames[c]).replace(/M/g, h.params.monthNamesShort[c]).replace(/dd/g, 10 > e ? "0" + e : e).replace(/d/g, e).replace(/DD/g, h.params.dayNames[f]).replace(/D/g, h.params.dayNamesShort[f])
        }

        function e(b) {
            if (b.preventDefault(),
                a.device.isWeixin && a.device.android && h.params.inputReadOnly && (this.focus(),
                    this.blur()),
                !h.opened && (h.open(),
                    h.params.scrollToInput)) {
                var c = h.input.parents(".content");
                if (0 === c.length)
                    return;
                var d, e = parseInt(c.css("padding-top"), 10), f = parseInt(c.css("padding-bottom"), 10), g = c[0].offsetHeight - e - h.container.height(), i = c[0].scrollHeight - e - h.container.height(), j = h.input.offset().top - e + h.input[0].offsetHeight;
                if (j > g) {
                    var k = c.scrollTop() + j - g;
                    k + g > i && (d = k + g - i + f,
                    g === i && (d = h.container.height()),
                        c.css({
                            "padding-bottom": d + "px"
                        })),
                        c.scrollTop(k, 300)
                }
            }
        }

        function f(b) {
            h.input && h.input.length > 0 ? b.target !== h.input[0] && 0 === a(b.target).parents(".picker-modal").length && h.close() : 0 === a(b.target).parents(".picker-modal").length && h.close()
        }

        function g() {
            h.opened = !1,
            h.input && h.input.length > 0 && h.input.parents(".content").css({
                "padding-bottom": ""
            }),
            h.params.onClose && h.params.onClose(h),
                h.destroyCalendarEvents()
        }

        var h = this
            , i = {
                monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                dayNames: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
                dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
                firstDay: 1,
                weekendDays: [0, 6],
                multiple: !1,
                dateFormat: "yyyy-mm-dd",
                direction: "horizontal",
                minDate: null,
                maxDate: null,
                touchMove: !0,
                animate: !0,
                closeOnSelect: !0,
                monthPicker: !0,
                monthPickerTemplate: '<div class="picker-calendar-month-picker"><a href="#" class="link icon-only picker-calendar-prev-month"><i class="icon icon-prev"></i></a><div class="current-month-value"></div><a href="#" class="link icon-only picker-calendar-next-month"><i class="icon icon-next"></i></a></div>',
                yearPicker: !0,
                yearPickerTemplate: '<div class="picker-calendar-year-picker"><a href="#" class="link icon-only picker-calendar-prev-year"><i class="icon icon-prev"></i></a><span class="current-year-value"></span><a href="#" class="link icon-only picker-calendar-next-year"><i class="icon icon-next"></i></a></div>',
                weekHeader: !0,
                scrollToInput: !0,
                inputReadOnly: !0,
                toolbar: !0,
                toolbarCloseText: "Done",
                toolbarTemplate: '<div class="toolbar"><div class="toolbar-inner">{{monthPicker}}{{yearPicker}}</div></div>'
            };
        c = c || {};
        for (var j in i)
            "undefined" == typeof c[j] && (c[j] = i[j]);
        h.params = c,
            h.initialized = !1,
            h.inline = h.params.container ? !0 : !1,
            h.isH = "horizontal" === h.params.direction;
        var k = h.isH && b ? -1 : 1;
        return h.animating = !1,
            h.addValue = function (a) {
                if (h.params.multiple) {
                    h.value || (h.value = []);
                    for (var b, c = 0; c < h.value.length; c++)
                        new Date(a).getTime() === new Date(h.value[c]).getTime() && (b = c);
                    "undefined" == typeof b ? h.value.push(a) : h.value.splice(b, 1),
                        h.updateValue()
                } else
                    h.value = [a],
                        h.updateValue()
            }
            ,
            h.setValue = function (a) {
                h.value = a,
                    h.updateValue()
            }
            ,
            h.updateValue = function () {
                h.wrapper.find(".picker-calendar-day-selected").removeClass("picker-calendar-day-selected");
                var b, c;
                for (b = 0; b < h.value.length; b++) {
                    var e = new Date(h.value[b]);
                    h.wrapper.find('.picker-calendar-day[data-date="' + e.getFullYear() + "-" + e.getMonth() + "-" + e.getDate() + '"]').addClass("picker-calendar-day-selected")
                }
                if (h.params.onChange && h.params.onChange(h, h.value, h.value.map(d)),
                    h.input && h.input.length > 0) {
                    if (h.params.formatValue)
                        c = h.params.formatValue(h, h.value);
                    else {
                        for (c = [],
                                 b = 0; b < h.value.length; b++)
                            c.push(d(h.value[b]));
                        c = c.join(", ")
                    }
                    a(h.input).val(c),
                        a(h.input).trigger("change")
                }
            }
            ,
            h.initCalendarEvents = function () {
                function c(a) {
                    i || g || (g = !0,
                        j = n = "touchstart" === a.type ? a.targetTouches[0].pageX : a.pageX,
                        l = n = "touchstart" === a.type ? a.targetTouches[0].pageY : a.pageY,
                        o = (new Date).getTime(),
                        u = 0,
                        x = !0,
                        w = void 0,
                        q = r = h.monthsTranslate)
                }

                function d(a) {
                    if (g) {
                        if (m = "touchmove" === a.type ? a.targetTouches[0].pageX : a.pageX,
                                n = "touchmove" === a.type ? a.targetTouches[0].pageY : a.pageY,
                            "undefined" == typeof w && (w = !!(w || Math.abs(n - l) > Math.abs(m - j))),
                            h.isH && w)
                            return void (g = !1);
                        if (a.preventDefault(),
                                h.animating)
                            return void (g = !1);
                        x = !1,
                        i || (i = !0,
                            s = h.wrapper[0].offsetWidth,
                            t = h.wrapper[0].offsetHeight,
                            h.wrapper.transition(0)),
                            a.preventDefault(),
                            v = h.isH ? m - j : n - l,
                            u = v / (h.isH ? s : t),
                            r = 100 * (h.monthsTranslate * k + u),
                            h.wrapper.transform("translate3d(" + (h.isH ? r : 0) + "%, " + (h.isH ? 0 : r) + "%, 0)")
                    }
                }

                function e(a) {
                    return g && i ? (g = i = !1,
                        p = (new Date).getTime(),
                        300 > p - o ? Math.abs(v) < 10 ? h.resetMonth() : v >= 10 ? b ? h.nextMonth() : h.prevMonth() : b ? h.prevMonth() : h.nextMonth() : -.5 >= u ? b ? h.prevMonth() : h.nextMonth() : u >= .5 ? b ? h.nextMonth() : h.prevMonth() : h.resetMonth(),
                        void setTimeout(function () {
                            x = !0
                        }, 100)) : void (g = i = !1)
                }

                function f(b) {
                    if (x) {
                        var c = a(b.target).parents(".picker-calendar-day");
                        if (0 === c.length && a(b.target).hasClass("picker-calendar-day") && (c = a(b.target)),
                            0 !== c.length && (!c.hasClass("picker-calendar-day-selected") || h.params.multiple) && !c.hasClass("picker-calendar-day-disabled")) {
                            c.hasClass("picker-calendar-day-next") && h.nextMonth(),
                            c.hasClass("picker-calendar-day-prev") && h.prevMonth();
                            var d = c.attr("data-year")
                                , e = c.attr("data-month")
                                , f = c.attr("data-day");
                            h.params.onDayClick && h.params.onDayClick(h, c[0], d, e, f),
                                h.addValue(new Date(d, e, f).getTime()),
                            h.params.closeOnSelect && h.close()
                        }
                    }
                }

                var g, i, j, l, m, n, o, p, q, r, s, t, u, v, w, x = !0;
                h.container.find(".picker-calendar-prev-month").on("click", h.prevMonth),
                    h.container.find(".picker-calendar-next-month").on("click", h.nextMonth),
                    h.container.find(".picker-calendar-prev-year").on("click", h.prevYear),
                    h.container.find(".picker-calendar-next-year").on("click", h.currentWeek),
                    h.wrapper.on("click", f),
                h.params.touchMove && (h.wrapper.on(a.touchEvents.start, c),
                    h.wrapper.on(a.touchEvents.move, d),
                    h.wrapper.on(a.touchEvents.end, e)),
                    h.container[0].f7DestroyCalendarEvents = function () {
                        h.container.find(".picker-calendar-prev-month").off("click", h.prevMonth),
                            h.container.find(".picker-calendar-next-month").off("click", h.nextMonth),
                            h.container.find(".picker-calendar-prev-year").off("click", h.prevYear),
                            h.container.find(".picker-calendar-next-year").off("click", h.currentWeek),
                            h.wrapper.off("click", f),
                        h.params.touchMove && (h.wrapper.off(a.touchEvents.start, c),
                            h.wrapper.off(a.touchEvents.move, d),
                            h.wrapper.off(a.touchEvents.end, e))
                    }
            }
            ,
            h.destroyCalendarEvents = function (a) {
                "f7DestroyCalendarEvents" in h.container[0] && h.container[0].f7DestroyCalendarEvents()
            }
            ,
            h.daysInMonth = function (a) {
                var b = new Date(a);
                return new Date(b.getFullYear(), b.getMonth() + 1, 0).getDate()
            }
            ,
            h.monthHTML = function (a, b) {

                console.log(a);
                a = new Date(a);
                var c = a.getFullYear()
                    , d = a.getMonth();
                a.getDate();


                console.log(a);


                var e = h.daysInMonth(new Date(a.getFullYear(), a.getMonth()).getTime() - 864e6)
                    , f = h.daysInMonth(a)
                    , g = new Date(a.getFullYear(), a.getMonth()).getDay();


                0 === g && (g = 7);
                var i, j, k, l = [], m = 6, n = 7, o = "", p = 0 + (h.params.firstDay - 1), q = (new Date).setHours(0, 0, 0, 0), r = h.params.minDate ? new Date(h.params.minDate).getTime() : null, s = h.params.maxDate ? new Date(h.params.maxDate).getTime() : null;
                if (h.value && h.value.length)
                    for (j = 0; j < h.value.length; j++)
                        l.push(new Date(h.value[j]).setHours(0, 0, 0, 0));


                var weekStart,
                    weekIndex;

                weekIndex = a.getDay();
                weekIndex == 0 && (weekIndex = 7);
                weekStart = new Date(a.getTime() - (weekIndex - 1) * 24 * 3600 * 1000);


                console.log(b);



                if ("next" === b) {
                    weekStart = new Date(weekStart.getTime() + 7 * 24 * 3600 * 1000);
                }
                if ("prev" === b) {
                    weekStart = new Date(weekStart.getTime() - 7 * 24 * 3600 * 1000);
                }
                var t = "";
                for (k = 0; n > k; k++) {
                    var i = new Date(weekStart.getTime() + k * 24 * 3600 * 1000),
                        w = "",
                        v = i.getDate();

                    if (k == 0 || k == 6) {
                        w += " picker-calendar-day-weekend"
                    }
                    l.indexOf(i.getTime()) >= 0 && (w += " picker-calendar-day-selected");

                    var x = i.getFullYear()
                        , y = i.getMonth();

                    t += '<div data-year="' + x + '" data-month="' + y + '" data-day="' + v + '" class="picker-calendar-day' + w + '" data-date="' + (x + "-" + y + "-" + v) + '"><span>' + v + "</span></div>"

                }
                o += '<div class="picker-calendar-row">' + t + "</div>"
                return o = '<div class="picker-calendar-month" data-year="' + c + '" data-monthStart="' + d +  '" data-monthEnd="' + y +'">' + o + "</div>";


            }
            ,
            h.animating = !1,
            h.updateCurrentMonthYear = function (a) {
                "undefined" == typeof a ? (h.currentMonth = parseInt(h.months.eq(1).attr("data-month"), 10),
                    h.currentYear = parseInt(h.months.eq(1).attr("data-year"), 10)) : (h.currentMonth = parseInt(h.months.eq("next" === a ? h.months.length - 1 : 0).attr("data-month"), 10),
                    h.currentYear = parseInt(h.months.eq("next" === a ? h.months.length - 1 : 0).attr("data-year"), 10)),
                    h.container.find(".current-month-value").text(h.params.monthNames[h.currentMonth]),
                    h.container.find(".current-year-value").text(h.currentYear)
            }
            ,
            h.onMonthChangeStart = function (a) {
                h.updateCurrentMonthYear(a),
                    h.months.removeClass("picker-calendar-month-current picker-calendar-month-prev picker-calendar-month-next");
                var b = "next" === a ? h.months.length - 1 : 0;
                h.months.eq(b).addClass("picker-calendar-month-current"),
                    h.months.eq("next" === a ? b - 1 : b + 1).addClass("next" === a ? "picker-calendar-month-prev" : "picker-calendar-month-next"),
                h.params.onMonthYearChangeStart && h.params.onMonthYearChangeStart(h, h.currentYear, h.currentMonth)
            }
            ,
            h.onMonthChangeEnd = function (a, b) {
                h.animating = !1;
                var c, d, e;


                var currentRow = $(".picker-calendar-month-current .picker-calendar-row .picker-calendar-day-weekend:first-child").eq(0),
                    year = parseInt(currentRow.attr("data-year"), 10),
                    month = parseInt(currentRow.attr("data-month"), 10),
                    day = parseInt(currentRow.attr("data-day"), 10);


                h.wrapper.find(".picker-calendar-month:not(.picker-calendar-month-prev):not(.picker-calendar-month-current):not(.picker-calendar-month-next)").remove(),
                "undefined" == typeof a && (a = "next",
                    b = !0),
                    b ? (h.wrapper.find(".picker-calendar-month-next, .picker-calendar-month-prev").remove(),
                        //d = h.monthHTML(new Date(h.currentYear, h.currentMonth), "prev"),
                        d = h.monthHTML(new Date(year, month, day), "prev"),
                        c = h.monthHTML(new Date(year, month,day), "next")) : e = h.monthHTML(new Date(year, month, day), a),
                    console.log(a),
                ("next" === a || b) && h.wrapper.append(e || c),
                ("prev" === a || b) && h.wrapper.prepend(e || d),
                    h.months = h.wrapper.find(".picker-calendar-month"),
                    h.setMonthsTranslate(h.monthsTranslate),
                h.params.onMonthAdd && h.params.onMonthAdd(h, "next" === a ? h.months.eq(h.months.length - 1)[0] : h.months.eq(0)[0]),
                h.params.onMonthYearChangeEnd && h.params.onMonthYearChangeEnd(h, h.currentYear, h.currentMonth)
            }
            ,
            h.setMonthsTranslate = function (a) {
                a = a || h.monthsTranslate || 0,
                "undefined" == typeof h.monthsTranslate && (h.monthsTranslate = a),
                    h.months.removeClass("picker-calendar-month-current picker-calendar-month-prev picker-calendar-month-next");
                var b = 100 * -(a + 1) * k
                    , c = 100 * -a * k
                    , d = 100 * -(a - 1) * k;
                h.months.eq(0).transform("translate3d(" + (h.isH ? b : 0) + "%, " + (h.isH ? 0 : b) + "%, 0)").addClass("picker-calendar-month-prev"),
                    h.months.eq(1).transform("translate3d(" + (h.isH ? c : 0) + "%, " + (h.isH ? 0 : c) + "%, 0)").addClass("picker-calendar-month-current"),
                    h.months.eq(2).transform("translate3d(" + (h.isH ? d : 0) + "%, " + (h.isH ? 0 : d) + "%, 0)").addClass("picker-calendar-month-next")
            }
            ,
            h.nextMonth = function (b) {
                ("undefined" == typeof b || "object" == typeof b) && (b = "",
                h.params.animate || (b = 0));
                var c = parseInt(h.months.eq(h.months.length - 1).attr("data-monthStart"), 10)
                    , day = parseInt(h.months.eq(h.months.length - 1).find(".picker-calendar-day-weekend:first-child").eq(0).attr("data-day"), 10)
                    , d = parseInt(h.months.eq(h.months.length - 1).attr("data-year"), 10)
//                             , e = new Date(d, c)
//                             , f = e.getTime()
                    , e = new Date(d, c, day)
                    , f = e.getTime() - 24 * 3600 * 1000
                    , g = h.animating ? !1 : !0;
                if (h.params.maxDate && f > new Date(h.params.maxDate).getTime())
                    return h.resetMonth();
                if (h.monthsTranslate--,
                    c === h.currentMonth) {
                    var i = 100 * -h.monthsTranslate * k
                        , j = a(h.monthHTML(f, "next")).transform("translate3d(" + (h.isH ? i : 0) + "%, " + (h.isH ? 0 : i) + "%, 0)").addClass("picker-calendar-month-next");
                    h.wrapper.append(j[0]),
                        h.months = h.wrapper.find(".picker-calendar-month"),
                    h.params.onMonthAdd && h.params.onMonthAdd(h, h.months.eq(h.months.length - 1)[0])
                }
                h.animating = !0,
                    h.onMonthChangeStart("next");
                var l = 100 * h.monthsTranslate * k;
                h.wrapper.transition(b).transform("translate3d(" + (h.isH ? l : 0) + "%, " + (h.isH ? 0 : l) + "%, 0)"),
                g && h.wrapper.transitionEnd(function () {
                    h.onMonthChangeEnd("next")
                }),
                h.params.animate || h.onMonthChangeEnd("next")
            }
            ,
            h.prevMonth = function (b) {
                ("undefined" == typeof b || "object" == typeof b) && (b = "",
                h.params.animate || (b = 0));
                var c = parseInt(h.months.eq(0).attr("data-monthEnd"), 10),
                    day = parseInt(h.months.eq(0).find(".picker-calendar-day-weekend:last-child").eq(0).attr("data-day"), 10)
                    , d = parseInt(h.months.eq(0).attr("data-year"), 10)
//                             , e = new Date(d, c + 1, -1)
//                             , f = e.getTime()+24*3600*1000
                    , e = new Date(d, c, day)
                    , f = e.getTime() + 24 * 3600 * 1000
                    , g = h.animating ? !1 : !0;



                if (h.params.minDate && f < new Date(h.params.minDate).getTime())
                    return h.resetMonth();
                if (h.monthsTranslate++,
                    c === h.currentMonth) {
                    var i = 100 * -h.monthsTranslate * k
                        , j = a(h.monthHTML(f, "prev")).transform("translate3d(" + (h.isH ? i : 0) + "%, " + (h.isH ? 0 : i) + "%, 0)").addClass("picker-calendar-month-prev");
                    h.wrapper.prepend(j[0]),
                        h.months = h.wrapper.find(".picker-calendar-month"),
                    h.params.onMonthAdd && h.params.onMonthAdd(h, h.months.eq(0)[0])
                }
                h.animating = !0,
                    h.onMonthChangeStart("prev");
                var l = 100 * h.monthsTranslate * k;
                h.wrapper.transition(b).transform("translate3d(" + (h.isH ? l : 0) + "%, " + (h.isH ? 0 : l) + "%, 0)"),
                g && h.wrapper.transitionEnd(function () {
                    h.onMonthChangeEnd("prev")
                }),
                h.params.animate || h.onMonthChangeEnd("prev")
            }
            ,
            h.resetMonth = function (a) {
                "undefined" == typeof a && (a = "");
                var b = 100 * h.monthsTranslate * k;
                h.wrapper.transition(a).transform("translate3d(" + (h.isH ? b : 0) + "%, " + (h.isH ? 0 : b) + "%, 0)")
            }
            ,
            h.setYearMonth = function (a, b, c) {
                "undefined" == typeof a && (a = h.currentYear),
                "undefined" == typeof b && (b = h.currentMonth),
                ("undefined" == typeof c || "object" == typeof c) && (c = "",
                h.params.animate || (c = 0));
                var d;
                if (d = a < h.currentYear ? new Date(a, b + 1, -1).getTime() : new Date(a, b).getTime(),
                    h.params.maxDate && d > new Date(h.params.maxDate).getTime())
                    return !1;
                if (h.params.minDate && d < new Date(h.params.minDate).getTime())
                    return !1;
                var e = new Date(h.currentYear, h.currentMonth).getTime()
                    , f = d > e ? "next" : "prev"
                    , g = h.monthHTML(new Date(a, b));
                h.monthsTranslate = h.monthsTranslate || 0;
                var i, j, l = h.monthsTranslate, m = h.animating ? !1 : !0;
                d > e ? (h.monthsTranslate--,
                h.animating || h.months.eq(h.months.length - 1).remove(),
                    h.wrapper.append(g),
                    h.months = h.wrapper.find(".picker-calendar-month"),
                    i = 100 * -(l - 1) * k,
                    h.months.eq(h.months.length - 1).transform("translate3d(" + (h.isH ? i : 0) + "%, " + (h.isH ? 0 : i) + "%, 0)").addClass("picker-calendar-month-next")) : (h.monthsTranslate++,
                h.animating || h.months.eq(0).remove(),
                    h.wrapper.prepend(g),
                    h.months = h.wrapper.find(".picker-calendar-month"),
                    i = 100 * -(l + 1) * k,
                    h.months.eq(0).transform("translate3d(" + (h.isH ? i : 0) + "%, " + (h.isH ? 0 : i) + "%, 0)").addClass("picker-calendar-month-prev")),
                h.params.onMonthAdd && h.params.onMonthAdd(h, "next" === f ? h.months.eq(h.months.length - 1)[0] : h.months.eq(0)[0]),
                    h.animating = !0,
                    h.onMonthChangeStart(f),
                    j = 100 * h.monthsTranslate * k,
                    h.wrapper.transition(c).transform("translate3d(" + (h.isH ? j : 0) + "%, " + (h.isH ? 0 : j) + "%, 0)"),
                m && h.wrapper.transitionEnd(function () {
                    h.onMonthChangeEnd(f, !0)
                }),
                h.params.animate || h.onMonthChangeEnd(f)
            }
            ,
            h.nextYear = function () {
                h.setYearMonth(h.currentYear + 1)
            }
            ,
            h.prevYear = function () {
                h.setYearMonth(h.currentYear - 1)
            },
            h.currentWeek = function () {
                var t= new Date(),
				    d= t.getTime(),
                    e = new Date(h.currentYear, h.currentMonth).getTime()|| new Date().getTime(),
                    f = d > e ? "next" : "prev";
                h.value = [t];
               var g = h.monthHTML(new Date(t.getFullYear(),t.getMonth(),t.getDate()));
                h.monthsTranslate = h.monthsTranslate || 0;
                var i, j, l = h.monthsTranslate, m = h.animating ? !1 : !0;
                d > e ? (h.monthsTranslate--,
                h.animating || h.months.eq(h.months.length - 1).remove(),
                    h.wrapper.append(g),
                    h.months = h.wrapper.find(".picker-calendar-month"),
                    i = 100 * -(l - 1) * k,
                    h.months.eq(h.months.length - 1).transform("translate3d(" + (h.isH ? i : 0) + "%, " + (h.isH ? 0 : i) + "%, 0)").addClass("picker-calendar-month-next")) : (h.monthsTranslate++,
                h.animating || h.months.eq(0).remove(),
                    h.wrapper.prepend(g),
                    h.months = h.wrapper.find(".picker-calendar-month"),
                    i = 100 * -(l + 1) * k,
                    h.months.eq(0).transform("translate3d(" + (h.isH ? i : 0) + "%, " + (h.isH ? 0 : i) + "%, 0)").addClass("picker-calendar-month-prev")),
                h.params.onMonthAdd && h.params.onMonthAdd(h, "next" === f ? h.months.eq(h.months.length - 1)[0] : h.months.eq(0)[0]),
                    h.animating = !0,
                    h.onMonthChangeStart(f),
                    j = 100 * h.monthsTranslate * k,
                    h.wrapper.transition(c).transform("translate3d(" + (h.isH ? j : 0) + "%, " + (h.isH ? 0 : j) + "%, 0)"),
                m && h.wrapper.transitionEnd(function () {
                    h.onMonthChangeEnd(f, !0)
                }),
                h.params.animate || h.onMonthChangeEnd(f);
            }
            ,
            h.layout = function () {
                var a, b = "", c = "", d = h.value && h.value.length ? h.value[0] : (new Date).setHours(0, 0, 0, 0), e = h.monthHTML(d, "prev"), f = h.monthHTML(d), g = h.monthHTML(d, "next"), i = '<div class="picker-calendar-months"><div class="picker-calendar-months-wrapper">' + (e + f + g) + "</div></div>", j = "";
                if (h.params.weekHeader) {
                    for (a = 0; 7 > a; a++) {
                        var k = a + h.params.firstDay > 6 ? a - 7 + h.params.firstDay : a + h.params.firstDay
                            , l = h.params.dayNamesShort[k];
                        j += '<div class="picker-calendar-week-day ' + (h.params.weekendDays.indexOf(k) >= 0 ? "picker-calendar-week-day-weekend" : "") + '"> ' + l + "</div>"
                    }
                    j = '<div class="picker-calendar-week-days">' + j + "</div>"
                }
                c = "picker-modal picker-calendar " + (h.params.cssClass || "");
                var m = h.params.toolbar ? h.params.toolbarTemplate.replace(/{{closeText}}/g, h.params.toolbarCloseText) : "";
                h.params.toolbar && (m = h.params.toolbarTemplate.replace(/{{closeText}}/g, h.params.toolbarCloseText).replace(/{{monthPicker}}/g, h.params.monthPicker ? h.params.monthPickerTemplate : "").replace(/{{yearPicker}}/g, h.params.yearPicker ? h.params.yearPickerTemplate : "")),
                    b = '<div class="' + c + '">' + m + '<div class="picker-modal-inner">' + j + i + "</div></div>",
                    h.pickerHTML = b
            }
            ,
        h.params.input && (h.input = a(h.params.input),
        h.input.length > 0 && (h.params.inputReadOnly && h.input.prop("readOnly", !0),
        h.inline || h.input.on("click", e))),
        h.inline || a("html").on("click", f),
            h.opened = !1,
            h.open = function () {
                var b = !1;
                h.opened || (h.value || h.params.value && (h.value = h.params.value,
                    b = !0),
                    h.layout(),
                    h.inline ? (h.container = a(h.pickerHTML),
                        h.container.addClass("picker-modal-inline"),
                        a(h.params.container).append(h.container)) : (h.container = a(a.pickerModal(h.pickerHTML)),
                        a(h.container).on("close", function () {
                            g()
                        })),
                    h.container[0].f7Calendar = h,
                    h.wrapper = h.container.find(".picker-calendar-months-wrapper"),
                    h.months = h.wrapper.find(".picker-calendar-month"),
                    h.updateCurrentMonthYear(),
                    h.monthsTranslate = 0,
                    h.setMonthsTranslate(),
                    h.initCalendarEvents(),
                b && h.updateValue()),
                    h.opened = !0,
                    h.initialized = !0,
                h.params.onMonthAdd && h.months.each(function () {
                    h.params.onMonthAdd(h, this)
                }),
                h.params.onOpen && h.params.onOpen(h)
            }
            ,
            h.close = function () {
                h.opened && !h.inline && a.closeModal(h.container)
            }
            ,
            h.destroy = function () {
                h.close(),
                h.params.input && h.input.length > 0 && h.input.off("click", e),
                    a("html").off("click", f)
            }
            ,
        h.inline && h.open(),
            h
    }
    $.fn.calendarWeek = function (b) {
        return this.each(function () {
            var d = $(this);
            if (d[0]) {
                var e = {};
                "INPUT" === d[0].tagName.toUpperCase() ? e.input = d : e.container = d, new calendarWeek($.extend(e, b))
            }
        })
    }
})($)