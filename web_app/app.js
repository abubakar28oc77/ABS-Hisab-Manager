/**
 * ABS Hisab Manager - Complete Interactive Web Application (v2.0)
 * Logic & Local Database Controller
 */

// ==================== I18N DICTIONARY ====================
// ==================== I18N DICTIONARY ====================
const translations = {
  bn: {
    app_name: 'ABS হিসাব ম্যানেজার-২',
    dashboard: 'ড্যাশবোর্ড',
    classes_nav: 'শ্রেণি',
    students: 'শিক্ষার্থী',
    transactions: 'লেনদেন',
    settings: 'সেটিংস',
    good_morning: 'শুভ সকাল',
    good_afternoon: 'শুভ দুপুর',
    good_evening: 'শুভ সন্ধ্যা',
    net_balance: 'নিট ব্যালেন্স',
    income: 'আয়',
    expense: 'ব্যয়',
    total_income_month: 'মোট আয়',
    total_expense_month: 'মোট ব্যয়',
    pending_fees: 'বাকি ফি',
    quick_actions: 'কুইক অ্যাকশন',
    quick_hajira: 'স্টুডেন্ট হাজিরা',
    quick_broadcast: 'গ্রুপ কল & SMS',
    quick_collect_fee: 'ফি গ্রহণ',
    quick_add_student: 'শিক্ষার্থী যোগ',
    quick_add_expense: 'ব্যয় যোগ',
    quick_reports: 'রিপোর্টস',
    recent_transactions: 'সাম্প্রতিক লেনদেন',
    see_all: 'সব দেখুন',
    expense_breakdown: 'ব্যয়ের বিবরণী',
    no_expenses_month: 'চলতি মাসে কোনো ব্যয় নেই',
    no_transactions_month: 'চলতি মাসে কোনো লেনদেন নেই',
    search_students: 'নাম, রোল, মোবাইল দিয়ে খুঁজুন...',
    all: 'সব',
    filter_all: 'সকল শ্রেণি',
    filter_due: 'বকেয়া আছে',
    filter_paid: 'পরিশোধিত',
    filter_advance: 'অগ্রিম',
    add_student: 'শিক্ষার্থী যোগ',
    edit_student: 'শিক্ষার্থী সম্পাদনা',
    student_profile: 'শিক্ষার্থীর প্রোফাইল',
    class_and_roll: 'শ্রেণি ও রোল',
    monthly_fee: 'মাসিক ফি',
    address: 'ঠিকানা',
    admission_date: 'ভর্তির তারিখ',
    fathers_name: 'অভিভাবকের নাম',
    fathers_mobile: 'অভিভাবকের মোবাইল',
    student_mobile: 'শিক্ষার্থীর মোবাইল',
    notes: 'নোট',
    direct_communication: 'সরাসরি যোগাযোগ',
    call: 'কল',
    sms: 'এসএমএস',
    whatsapp: 'হোয়াটসঅ্যাপ',
    telegram: 'টেলিগ্রাম',
    save_contact: 'সেভ',
    total_expected: 'মোট প্রত্যাশিত',
    total_paid: 'মোট পরিশোধিত',
    due: 'বাকি',
    advance: 'অগ্রিম',
    paid_status: 'পরিশোধিত',
    payment_history: 'পেমেন্ট ইতিহাস',
    no_payments_yet: 'কোনো পেমেন্ট রেকর্ড নেই',
    class_attendance: 'ক্লাস উপস্থিতি',
    classes: 'ক্লাস',
    collect_payment: 'পেমেন্ট সংগ্রহ',
    current_due: 'বর্তমান বাকি',
    amount: 'টাকার পরিমাণ',
    payment_method: 'পেমেন্ট মাধ্যম',
    payment_date: 'পেমেন্টের তারিখ',
    month_hint: 'প্রযোজ্য মাস',
    receipt_now_desc: 'এখনই মানি রিসিট (Receipt) তৈরি করবেন?',
    save_payment: 'পেমেন্ট সংরক্ষণ করুন',
    delete_confirm: 'আপনি কি নিশ্চিত এটি মুছে ফেলতে চান?',
    no_phone_msg: 'অভিভাবকের মোবাইল নম্বর দেওয়া হয়নি!',
    no_due_msg: 'শিক্ষার্থীর কোনো বকেয়া ফি নেই!',
    receipt_given: 'রশিদ দেওয়া হয়েছে',
    no_receipt: 'রশিদ নেই',
    statement_pdf: 'স্টেটমেন্ট PDF',
    language: 'ভাষা (Language)',
    lang_desc: 'অ্যাপের ভাষা পরিবর্তন করুন',
    app_language: 'অ্যাপের ভাষা',
    security: 'নিরাপত্তা (Security)',
    pin_lock: 'অ্যাপ লক (PIN)',
    pin_lock_desc: '৪-ডিজিটের পিন কোড সেট করুন',
    finance: 'আর্থিক হিসাব (Finance)',
    manage_categories: 'ক্যাটাগরি ম্যানেজমেন্ট',
    manage_categories_desc: 'আয় ও ব্যয়ের ক্যাটাগরি তৈরি/সম্পাদনা',
    financial_reports: 'আর্থিক রিপোর্ট',
    financial_reports_desc: 'দৈনিক, সাপ্তাহিক, মাসিক ও বার্ষিক রিপোর্ট PDF',
    data_backup: 'ডাটা ও ব্যাকআপ',
    restore_17: '১৭ জন শিক্ষার্থীর ডাটা রিস্টোর / সিঙ্ক',
    restore_17_desc: 'Class 6 ও 7 এর ১৭ জন শিক্ষার্থীর মূল তালিকা আনুন',
    export_backup: 'ব্যাকআপ এক্সপোর্ট (JSON)',
    export_desc: 'সকল ডাটা ফাইল আকারে ডাউনলোড করুন',
    import_backup: 'ব্যাকআপ রিস্টোর (JSON)',
    import_desc: 'JSON ফাইল থেকে ডাটা রিস্টোর করুন',
    clear_all: 'সকল ডাটা মুছুন',
    clear_desc: 'স্থায়ীভাবে সব শিক্ষার্থী ও লেনদেন ডিলিট',
    about: 'সম্পর্কে',
    about_title: 'ABS Hisab Manager v2.0.0',
    about_desc: 'লোকাল-ফার্স্ট প্রাইভেট টিউটর ও ফিন্যান্স ম্যানেজার',
    hajira_title: 'স্টুডেন্ট হাজিরা',
    broadcast_title: 'গ্রুপ কল & ব্রডকাস্ট SMS',
    no_students_found: 'কোনো শিক্ষার্থী পাওয়া যায়নি',
    no_students_saved: 'কোনো শিক্ষার্থী সংরক্ষিত নেই',
    load_17_students: '১৭ জন শিক্ষার্থী লোড করুন',
  },
  en: {
    app_name: 'ABS Hisab Manager-2',
    dashboard: 'Dashboard',
    classes_nav: 'Classes',
    students: 'Students',
    transactions: 'Transactions',
    settings: 'Settings',
    good_morning: 'Good morning',
    good_afternoon: 'Good afternoon',
    good_evening: 'Good evening',
    net_balance: 'Net Balance',
    income: 'Income',
    expense: 'Expense',
    total_income_month: 'Total Income',
    total_expense_month: 'Total Expense',
    pending_fees: 'Pending Fees',
    quick_actions: 'Quick Actions',
    quick_hajira: 'Student Attendance',
    quick_broadcast: 'Group Call & SMS',
    quick_collect_fee: 'Collect Fee',
    quick_add_student: 'Add Student',
    quick_add_expense: 'Add Expense',
    quick_reports: 'Reports',
    recent_transactions: 'Recent Transactions',
    see_all: 'See all',
    expense_breakdown: 'Expense Breakdown',
    no_expenses_month: 'No expenses recorded this month',
    no_transactions_month: 'No transactions recorded this month',
    search_students: 'Search by name, roll, phone...',
    all: 'All',
    filter_all: 'All Classes',
    filter_due: 'With Due',
    filter_paid: 'Paid',
    filter_advance: 'Advance',
    add_student: 'Add Student',
    edit_student: 'Edit Student',
    student_profile: 'Student Profile',
    class_and_roll: 'Class & Roll',
    monthly_fee: 'Monthly Fee',
    address: 'Address',
    admission_date: 'Admission Date',
    fathers_name: 'Guardian Name',
    fathers_mobile: 'Guardian Phone',
    student_mobile: 'Student Phone',
    notes: 'Notes',
    direct_communication: 'Direct Communication',
    call: 'Call',
    sms: 'SMS',
    whatsapp: 'WhatsApp',
    telegram: 'Telegram',
    save_contact: 'Save',
    total_expected: 'Total Expected',
    total_paid: 'Total Paid',
    due: 'Due',
    advance: 'Advance',
    paid_status: 'Paid',
    payment_history: 'Payment History',
    no_payments_yet: 'No payment records yet',
    class_attendance: 'Class Attendance',
    classes: 'classes',
    collect_payment: 'Collect Payment',
    current_due: 'Current Due',
    amount: 'Amount',
    payment_method: 'Payment Method',
    payment_date: 'Payment Date',
    month_hint: 'For Month',
    receipt_now_desc: 'Generate Money Receipt now?',
    save_payment: 'Save Payment & Generate Receipt',
    delete_confirm: 'Are you sure you want to delete this?',
    no_phone_msg: 'Guardian phone number is empty!',
    no_due_msg: 'Student has no pending due!',
    receipt_given: 'Receipt given',
    no_receipt: 'No receipt',
    statement_pdf: 'Statement PDF',
    language: 'Language',
    lang_desc: 'Switch application language',
    app_language: 'App Language',
    security: 'Security',
    pin_lock: 'App Lock (PIN)',
    pin_lock_desc: 'Set 4-digit security PIN',
    finance: 'Finance',
    manage_categories: 'Category Management',
    manage_categories_desc: 'Create/Edit Income & Expense Categories',
    financial_reports: 'Financial Reports',
    financial_reports_desc: 'Daily, Weekly, Monthly & Yearly PDF Reports',
    data_backup: 'Data & Backup',
    restore_17: 'Restore 17 Students Data',
    restore_17_desc: 'Load original 17 students of Class 6 & 7',
    export_backup: 'Export Backup (JSON)',
    export_desc: 'Download all data as a backup file',
    import_backup: 'Restore Backup (JSON)',
    import_desc: 'Restore data from a JSON file',
    clear_all: 'Delete All Data',
    clear_desc: 'Permanently remove all students & transactions',
    about: 'About',
    about_title: 'ABS Hisab Manager v2.0.0',
    about_desc: 'Local-First Private Tutor & Finance Manager',
    hajira_title: 'Student Attendance',
    broadcast_title: 'Group Call & Broadcast SMS',
    no_students_found: 'No students found',
    no_students_saved: 'No students saved yet',
    load_17_students: 'Load 17 Students',
  }
};

// ==================== DEFAULT INITIAL SAMPLE DATA ====================
const defaultCategories = {
  income: ['Tuition', 'Salary', 'Bonus', 'Other Income'],
  expense: ['Food', 'Travel', 'Books', 'Bills', 'Rent', 'Shopping', 'Other']
};

const defaultClasses = [
  { id: 'cls-1', name: 'Class 6', sections: ['A', 'B'], subjects: ['গণিত', 'ইংরেজি', 'বিজ্ঞান', 'বাংলা'] },
  { id: 'cls-2', name: 'Class 7', sections: ['A', 'B'], subjects: ['গণিত', 'ইংরেজি', 'বিজ্ঞান', 'বাংলা'] },
  { id: 'cls-3', name: 'Class 8', sections: ['A', 'B'], subjects: ['গণিত', 'ইংরেজি', 'বিজ্ঞান', 'বাংলা'] },
  { id: 'cls-4', name: 'Class 9', sections: ['Science', 'Commerce', 'Arts'], subjects: ['উচ্চতর গণিত', 'পদার্থবিজ্ঞান', 'রসায়ন', 'ইংরেজি'] },
  { id: 'cls-5', name: 'Class 10', sections: ['Science', 'Commerce', 'Arts'], subjects: ['উচ্চতর গণিত', 'পদার্থবিজ্ঞান', 'রসায়ন', 'ইংরেজি'] }
];

const defaultStudents = [
  {
    id: 'std-1',
    name: 'MD. HASAN MANDAL',
    className: 'Class 6',
    rollNumber: '6',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. BABUL MONDAL',
    fatherPhone: '01741264228',
    studentPhone: '',
    address: 'Betbari, Tangail Sadar, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-2',
    name: 'NIROB',
    className: 'Class 6',
    rollNumber: '13',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. NAZRUL ISLAM',
    fatherPhone: '01719399022',
    studentPhone: '',
    address: 'Betbari, Tangail Sadar, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-3',
    name: 'NAFIZUL UL HAQUE',
    className: 'Class 6',
    rollNumber: '14',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'SAJEDUL ISLAM',
    fatherPhone: '01710259032',
    studentPhone: '',
    address: 'Betbari, Tangail Sadar, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-4',
    name: 'MAHIM BHUIYA',
    className: 'Class 6',
    rollNumber: '28',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. MOSHARAF BHUYAN',
    fatherPhone: '01753152326',
    studentPhone: '',
    address: 'Tuni Magra, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-5',
    name: 'IMRAN',
    className: 'Class 6',
    rollNumber: '79',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'JOHER',
    fatherPhone: '01710689846',
    studentPhone: '',
    address: 'Dholkan Palpara, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-6',
    name: 'SHIMANTA DAS',
    className: 'Class 6',
    rollNumber: '96',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'KHUSHI CHANDRA DAS',
    fatherPhone: '01753539680',
    studentPhone: '',
    address: 'Betbari, Tangail Sadar, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-7',
    name: 'SUPTO GHOSH',
    className: 'Class 7',
    rollNumber: '1',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'SHUKUMAR CHANDRA GHOSH',
    fatherPhone: '01723450534',
    studentPhone: '',
    address: 'Dholkan Palpara, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-8',
    name: 'ASIF FUYAD',
    className: 'Class 7',
    rollNumber: '4',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. ISMAIL HOSSAIN BHUIYAN',
    fatherPhone: '01756346890',
    studentPhone: '',
    address: 'Dasokia, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-9',
    name: 'MD. IMRAN',
    className: 'Class 7',
    rollNumber: '6',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. ABDUR RASHID',
    fatherPhone: '01720584931',
    studentPhone: '',
    address: 'Betbari, Tangail Sadar, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-10',
    name: 'MD. ABDULLAH',
    className: 'Class 7',
    rollNumber: '11',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. MOKADDES ALI',
    fatherPhone: '01917213701',
    studentPhone: '',
    address: 'South Khasmagra, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-11',
    name: 'ALIF HOSSAIN',
    className: 'Class 7',
    rollNumber: '24',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. DULAL HOSSAIN',
    fatherPhone: '01746062194',
    studentPhone: '',
    address: 'Kuizbari, Tangail Sadar, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-12',
    name: 'MD. SAMIUL',
    className: 'Class 7',
    rollNumber: '30',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. ABUBAKAR SIDDIK',
    fatherPhone: '01725313663',
    studentPhone: '',
    address: 'Tuni Magra, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-13',
    name: 'SAMIUL ISLAM',
    className: 'Class 7',
    rollNumber: '39',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. SHAHIDUL ISLAM',
    fatherPhone: '01602727295',
    studentPhone: '',
    address: 'Dholkan Palpara, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-14',
    name: 'ADITTO KARMAKAR',
    className: 'Class 7',
    rollNumber: '41',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'BUDDHADEB KARMAKAR',
    fatherPhone: '01730603155',
    studentPhone: '',
    address: 'Tuni Magra, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-15',
    name: 'MD. ALHAZ',
    className: 'Class 7',
    rollNumber: '46',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. ABU TALEB',
    fatherPhone: '01720812611',
    studentPhone: '',
    address: 'Betbari, Tangail Sadar, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-16',
    name: 'MD. RIYAD HOSEN',
    className: 'Class 7',
    rollNumber: '59',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. BABUL HOSSAIN',
    fatherPhone: '01741007262',
    studentPhone: '',
    address: 'Dholkan Palpara, Kalihati, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  },
  {
    id: 'std-17',
    name: 'RAIYAN',
    className: 'Class 7',
    rollNumber: '66',
    section: 'A',
    monthlyFee: 500,
    fatherName: 'MD. RANA',
    fatherPhone: '01316885870',
    studentPhone: '',
    address: 'South Magra, Tangail Sadar, Tangail',
    admissionDate: '2026-07-20',
    notes: '',
    attendance: {}
  }
];

const defaultPayments = [];

const defaultTransactions = [];

// ==================== APP STATE STORE ====================
const DB_VERSION_17_KEY = 'abs_hisab_v2_synced_17_students_final';

class AppState {
  constructor() {
    this.storagePrefix = 'abs_hisab_';
    this.classes = this.load('classes', defaultClasses);
    
    const storedStudents = this.load('students', null);
    const syncDone = localStorage.getItem(DB_VERSION_17_KEY);

    if (!syncDone || !storedStudents || storedStudents.length === 0 || (storedStudents.length <= 3 && storedStudents.some(s => s.name && (s.name.includes('Rafsan') || s.name.includes('রাফসান'))))) {
      this.students = JSON.parse(JSON.stringify(defaultStudents));
      this.payments = [];
      this.transactions = [];
      localStorage.setItem(DB_VERSION_17_KEY, 'true');
      this.save();
    } else {
      this.students = storedStudents;
      this.payments = this.load('payments', defaultPayments);
      this.transactions = this.load('transactions', defaultTransactions);
    }
    
    this.categories = this.load('categories', defaultCategories);
    this.settings = this.load('settings', { lang: 'bn', pin: '', theme: 'light' });
    
    this.currentView = 'dashboard';
    this.studentStatusFilter = 'all';
    this.studentClassFilter = 'All';
    this.txnTypeFilter = 'all';
    this.selectedStudentId = null;
    this.reportAnchorDate = new Date();
    this.currentReportPeriod = 'monthly';
    this.enteredPin = '';
  }

  load(key, fallback) {
    try {
      const data = localStorage.getItem(this.storagePrefix + key);
      return data ? JSON.parse(data) : fallback;
    } catch {
      return fallback;
    }
  }

  save() {
    try {
      localStorage.setItem(this.storagePrefix + 'classes', JSON.stringify(this.classes));
      localStorage.setItem(this.storagePrefix + 'students', JSON.stringify(this.students));
      localStorage.setItem(this.storagePrefix + 'payments', JSON.stringify(this.payments));
      localStorage.setItem(this.storagePrefix + 'transactions', JSON.stringify(this.transactions));
      localStorage.setItem(this.storagePrefix + 'categories', JSON.stringify(this.categories));
      localStorage.setItem(this.storagePrefix + 'settings', JSON.stringify(this.settings));
    } catch (e) {
      console.error('Storage save error', e);
    }
  }

  t(key) {
    const lang = this.settings.lang || 'bn';
    return (translations[lang] && translations[lang][key]) || translations['en'][key] || key;
  }

  // Calculations
  getMonthIncome(month, year) {
    return this.transactions
      .filter(t => {
        if (t.type !== 'income') return false;
        const d = new Date(t.date);
        return d.getMonth() === month && d.getFullYear() === year;
      })
      .reduce((sum, t) => sum + Number(t.amount), 0);
  }

  getMonthExpense(month, year) {
    return this.transactions
      .filter(t => {
        if (t.type !== 'expense') return false;
        const d = new Date(t.date);
        return d.getMonth() === month && d.getFullYear() === year;
      })
      .reduce((sum, t) => sum + Number(t.amount), 0);
  }

  getTotalExpected(student) {
    if (!student.admissionDate) return Number(student.monthlyFee) || 0;
    const adm = new Date(student.admissionDate);
    if (isNaN(adm.getTime())) return Number(student.monthlyFee) || 0;
    const now = new Date();
    let months = (now.getFullYear() - adm.getFullYear()) * 12 + (now.getMonth() - adm.getMonth());
    if (now.getDate() < adm.getDate()) months -= 1;
    if (months < 0) months = 0;
    return months * (Number(student.monthlyFee) || 0);
  }

  getTotalPaid(studentId) {
    return this.payments
      .filter(p => p.studentId === studentId)
      .reduce((sum, p) => sum + Number(p.amount), 0);
  }

  getStudentDue(student) {
    const expected = this.getTotalExpected(student);
    const paid = this.getTotalPaid(student.id);
    return Math.max(0, expected - paid);
  }

  getStudentAdvance(student) {
    const expected = this.getTotalExpected(student);
    const paid = this.getTotalPaid(student.id);
    return Math.max(0, paid - expected);
  }

  getPendingFeesTotal() {
    return this.students.reduce((sum, s) => sum + this.getStudentDue(s), 0);
  }

  getExpenseCategoryBreakdown(month, year) {
    const now = new Date();
    const m = month !== undefined ? month : now.getMonth();
    const y = year !== undefined ? year : now.getFullYear();
    const map = {};

    this.transactions
      .filter(t => {
        if (t.type !== 'expense') return false;
        const d = new Date(t.date);
        return d.getMonth() === m && d.getFullYear() === y;
      })
      .forEach(t => {
        const cat = t.category || 'Other';
        map[cat] = (map[cat] || 0) + Number(t.amount);
      });
    return map;
  }
}

const state = new AppState();

// ==================== INITIALIZATION ====================
document.addEventListener('DOMContentLoaded', () => {
  applyLanguage();
  checkPinLock();
  renderDashboard();
  renderClassesList();
  renderStudentClassFilterChips();
  renderStudentsList();
  renderTransactionsList();
  renderCategoriesList();
  
  // Set default dates on forms
  const today = new Date().toISOString().split('T')[0];
  const curMonth = today.substring(0, 7);
  if (document.getElementById('fmAdmissionDate')) document.getElementById('fmAdmissionDate').value = today;
  if (document.getElementById('pmDate')) document.getElementById('pmDate').value = today;
  if (document.getElementById('pmMonth')) document.getElementById('pmMonth').value = curMonth;
  if (document.getElementById('txnDate')) document.getElementById('txnDate').value = today;
});

// ==================== LANGUAGE & LOCALIZATION ====================
function setLanguage(lang) {
  state.settings.lang = lang;
  state.save();
  applyLanguage();
  renderDashboard();
  renderClassesList();
  renderStudentClassFilterChips();
  renderStudentsList();
  renderTransactionsList();
  if (state.selectedStudentId) renderStudentDetail(state.selectedStudentId);
}

function applyLanguage() {
  const isBn = state.settings.lang === 'bn';
  const langLabel = document.getElementById('currentLangLabel');
  if (langLabel) langLabel.innerText = isBn ? 'EN' : 'বাং';
  
  const btnEn = document.getElementById('langBtnEn');
  const btnBn = document.getElementById('langBtnBn');
  if (btnEn) btnEn.classList.toggle('active', !isBn);
  if (btnBn) btnBn.classList.toggle('active', isBn);

  // Time based greeting
  const hour = new Date().getHours();
  const greetingKey = hour < 12 ? 'good_morning' : hour < 17 ? 'good_afternoon' : 'good_evening';
  const greetEl = document.getElementById('greetingText');
  if (greetEl) greetEl.innerText = state.t(greetingKey);
  
  const appTitleEl = document.getElementById('appTitle');
  if (appTitleEl) appTitleEl.innerText = state.t('app_name');

  const setTxt = (id, key) => {
    const el = document.getElementById(id);
    if (el) el.innerText = state.t(key);
  };

  // Dashboard translations
  setTxt('netBalanceLabel', 'net_balance');
  setTxt('quickActionsTitle', 'quick_actions');
  setTxt('qaHajiraLabel', 'quick_hajira');
  setTxt('qaGroupCallLabel', 'quick_broadcast');
  setTxt('qaCollectLabel', 'quick_collect_fee');
  setTxt('qaStudentLabel', 'quick_add_student');
  setTxt('qaExpenseLabel', 'quick_add_expense');
  setTxt('qaReportLabel', 'quick_reports');
  
  setTxt('lblIncomeMonth', 'total_income_month');
  setTxt('lblExpenseMonth', 'total_expense_month');
  setTxt('lblPendingFees', 'pending_fees');
  setTxt('lblTotalStudents', 'students');
  setTxt('lblExpenseBreakdown', 'expense_breakdown');
  setTxt('lblRecentTransactions', 'recent_transactions');
  setTxt('btnSeeAllTxn', 'see_all');

  // Navigation labels
  setTxt('navLblDashboard', 'dashboard');
  setTxt('navLblClasses', 'classes_nav');
  setTxt('navLblStudents', 'students');
  setTxt('navLblTransactions', 'transactions');
  setTxt('navLblSettings', 'settings');

  // Student list search placeholder
  const searchInput = document.getElementById('studentSearchInput');
  if (searchInput) searchInput.placeholder = state.t('search_students');

  // Filter chips in Student tab
  const chipAll = document.querySelector('#studentStatusChips .chip[data-status="all"]');
  const chipDue = document.querySelector('#studentStatusChips .chip[data-status="due"]');
  const chipPaid = document.querySelector('#studentStatusChips .chip[data-status="paid"]');
  const chipAdv = document.querySelector('#studentStatusChips .chip[data-status="advance"]');
  if (chipAll) chipAll.innerText = state.t('all');
  if (chipDue) chipDue.innerText = state.t('filter_due');
  if (chipPaid) chipPaid.innerText = state.t('filter_paid');
  if (chipAdv) chipAdv.innerText = state.t('filter_advance');

  // Settings Section labels
  setTxt('secTitleLang', 'language');
  setTxt('lblCurrentLang', 'app_language');
  setTxt('secTitleSecurity', 'security');
  setTxt('lblPinTitle', 'pin_lock');
  setTxt('lblPinDesc', 'pin_lock_desc');
  setTxt('secTitleFinance', 'finance');
  setTxt('lblManageCat', 'manage_categories');
  setTxt('lblManageCatDesc', 'manage_categories_desc');
  setTxt('lblFullReports', 'financial_reports');
  setTxt('lblFullReportsDesc', 'financial_reports_desc');
  setTxt('secTitleBackup', 'data_backup');
  setTxt('lblRestore17', 'restore_17');
  setTxt('lblRestore17Desc', 'restore_17_desc');
  setTxt('lblExportBackup', 'export_backup');
  setTxt('lblExportDesc', 'export_desc');
  setTxt('lblImportBackup', 'import_backup');
  setTxt('lblImportDesc', 'import_desc');
  setTxt('lblClearAll', 'clear_all');
  setTxt('lblClearDesc', 'clear_desc');
  setTxt('secTitleAbout', 'about');
  setTxt('lblAboutTitle', 'about_title');
  setTxt('lblAboutDesc', 'about_desc');
}

// Language toggle header button
document.getElementById('langToggleBtn').addEventListener('click', () => {
  const nextLang = state.settings.lang === 'bn' ? 'en' : 'bn';
  setLanguage(nextLang);
});

// ==================== NAVIGATION TABS ====================
function switchNavTab(tabName) {
  state.currentView = tabName;
  document.querySelectorAll('.tab-content .view').forEach(el => el.classList.remove('active'));
  document.querySelectorAll('.bottom-nav .nav-item').forEach(el => el.classList.remove('active'));

  const viewEl = document.getElementById(`${tabName}View`);
  const navBtn = document.querySelector(`.bottom-nav .nav-item[data-tab="${tabName}"]`);
  if (viewEl) viewEl.classList.add('active');
  if (navBtn) navBtn.classList.add('active');

  // Update FAB visibility / action
  const fab = document.getElementById('fabBtn');
  if (tabName === 'dashboard' || tabName === 'transactions') {
    fab.style.display = 'flex';
    fab.innerHTML = '<i class="fa-solid fa-plus"></i>';
  } else if (tabName === 'classes') {
    fab.style.display = 'flex';
    fab.innerHTML = '<i class="fa-solid fa-folder-plus"></i>';
  } else if (tabName === 'students') {
    fab.style.display = 'flex';
    fab.innerHTML = '<i class="fa-solid fa-user-plus"></i>';
  } else {
    fab.style.display = 'none';
  }

  // Refresh view data
  if (tabName === 'dashboard') renderDashboard();
  if (tabName === 'classes') renderClassesList();
  if (tabName === 'students') {
    renderStudentClassFilterChips();
    renderStudentsList();
  }
  if (tabName === 'transactions') renderTransactionsList();
}

function onFabClicked() {
  if (state.currentView === 'classes') {
    openAddClassModal();
  } else if (state.currentView === 'students') {
    openAddStudentModal();
  } else {
    openAddTransactionModal('expense');
  }
}

// ==================== DASHBOARD RENDERING ====================
function renderDashboard() {
  const now = new Date();
  const curMonth = now.getMonth();
  const curYear = now.getFullYear();

  const thisMonthIncome = state.getMonthIncome(curMonth, curYear);
  const thisMonthExpense = state.getMonthExpense(curMonth, curYear);
  const thisMonthNet = thisMonthIncome - thisMonthExpense;

  // Requirement 1: Clean Net Balance (no last month's +/- diff subtitle)
  document.getElementById('netBalanceAmount').innerText = `৳ ${thisMonthNet.toLocaleString('en-IN', { minimumFractionDigits: 2 })}`;

  // Requirement 1: Total Income & Total Expense without "this month" label
  document.getElementById('valIncomeMonth').innerText = `৳ ${thisMonthIncome.toLocaleString('en-IN')}`;
  document.getElementById('valExpenseMonth').innerText = `৳ ${thisMonthExpense.toLocaleString('en-IN')}`;
  document.getElementById('valPendingFees').innerText = `৳ ${state.getPendingFeesTotal().toLocaleString('en-IN')}`;
  document.getElementById('valTotalStudents').innerText = `${state.students.length}`;

  // Requirement 1: Draw Expense Pie Chart for current month only
  drawExpensePieChart();

  // Requirement 1: Render Recent Transactions for current month only
  const recentList = document.getElementById('recentTxnList');
  const currentMonthTxns = state.transactions.filter(t => {
    const d = new Date(t.date);
    return d.getMonth() === curMonth && d.getFullYear() === curYear;
  });
  const sorted = [...currentMonthTxns].sort((a, b) => new Date(b.date) - new Date(a.date)).slice(0, 5);
  
  if (sorted.length === 0) {
    recentList.innerHTML = `<div style="text-align:center; padding:18px; color:var(--text-muted); font-size:13px;">${state.t('no_transactions_month')}</div>`;
  } else {
    recentList.innerHTML = sorted.map(t => renderTxnCardHtml(t)).join('');
  }
}

function drawExpensePieChart() {
  const canvas = document.getElementById('expensePieChart');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  const breakdown = state.getExpenseCategoryBreakdown();
  const entries = Object.entries(breakdown);
  const total = entries.reduce((s, [, v]) => s + v, 0);
  const legend = document.getElementById('expenseChartLegend');

  ctx.clearRect(0, 0, canvas.width, canvas.height);

  if (total === 0 || entries.length === 0) {
    ctx.beginPath();
    ctx.arc(60, 60, 48, 0, 2 * Math.PI);
    ctx.strokeStyle = '#e2e8f0';
    ctx.lineWidth = 14;
    ctx.stroke();
    legend.innerHTML = `<div style="font-size:12px; color:var(--text-muted);">${state.t('no_expenses_month')}</div>`;
    return;
  }

  const colors = ['#4f46e5', '#06b6d4', '#f59e0b', '#ef4444', '#8b5cf6', '#10b981', '#f97316', '#64748b'];
  let startAngle = -Math.PI / 2;

  entries.forEach(([cat, amt], i) => {
    const sliceAngle = (amt / total) * 2 * Math.PI;
    ctx.beginPath();
    ctx.arc(60, 60, 46, startAngle, startAngle + sliceAngle);
    ctx.strokeStyle = colors[i % colors.length];
    ctx.lineWidth = 18;
    ctx.stroke();
    startAngle += sliceAngle;
  });

  // Render Legend
  legend.innerHTML = entries.map(([cat, amt], i) => {
    const pct = Math.round((amt / total) * 100);
    const color = colors[i % colors.length];
    return `
      <div class="legend-item">
        <div class="legend-left">
          <div class="legend-dot" style="background:${color}"></div>
          <span>${cat}</span>
        </div>
        <span class="legend-pct">${pct}%</span>
      </div>
    `;
  }).join('');
}

function renderTxnCardHtml(t) {
  const isIncome = t.type === 'income';
  const icon = isIncome ? 'fa-arrow-down-left' : 'fa-arrow-up-right';
  return `
    <div class="txn-item-card ${isIncome ? 'txn-income' : 'txn-expense'}">
      <div class="txn-left">
        <div class="txn-icon"><i class="fa-solid ${icon}"></i></div>
        <div>
          <div class="txn-category">${t.category}</div>
          <div class="txn-date">${t.date} ${t.note ? '· ' + t.note : ''}</div>
        </div>
      </div>
      <div style="display:flex; align-items:center;">
        <span class="txn-amount">${isIncome ? '+' : '-'}৳ ${Number(t.amount).toLocaleString('en-IN')}</span>
        <button class="txn-delete-btn" onclick="deleteTransaction('${t.id}')" title="Delete"><i class="fa-solid fa-trash-can"></i></button>
      </div>
    </div>
  `;
}

// ==================== REQUIREMENT 2: CLASSES & SUBJECTS MANAGEMENT ====================
function renderClassesList() {
  const listEl = document.getElementById('classesList');
  if (!listEl) return;

  if (state.classes.length === 0) {
    listEl.innerHTML = `
      <div style="text-align:center; padding:36px 20px; color:var(--text-muted); background:white; border-radius:14px; border:1px solid var(--border);">
        <i class="fa-solid fa-graduation-cap" style="font-size:36px; opacity:0.3; margin-bottom:10px;"></i>
        <p style="font-size:14px; font-weight:600;">কোনো শ্রেণি যুক্ত করা হয়নি</p>
        <button class="pill-btn btn-income mt-2" style="background:#2563eb; color:white;" onclick="openAddClassModal()">+ প্রথম শ্রেণি যোগ করুন</button>
      </div>
    `;
    return;
  }

let activeClassSections = [];
let activeClassSubjects = [];

function renderClassesList() {
  const listEl = document.getElementById('classesListContainer');
  if (!listEl) return;

  if (state.classes.length === 0) {
    listEl.innerHTML = `
      <div style="text-align:center; padding:40px 20px; color:var(--text-muted);">
        <i class="fa-solid fa-graduation-cap" style="font-size:36px; opacity:0.3; margin-bottom:10px;"></i>
        <p style="font-size:14px; font-weight:600;">কোনো শ্রেণি যুক্ত করা হয়নি</p>
        <button class="pill-btn btn-income mt-2" style="background:#4F46E5; color:white;" onclick="openAddClassModal()">+ শ্রেণি যোগ করুন</button>
      </div>
    `;
    return;
  }

  listEl.innerHTML = state.classes.map(cls => {
    const studentCount = state.students.filter(s => s.className === cls.name).length;
    const sections = (cls.sections && cls.sections.length > 0) ? cls.sections : ['A'];
    const subjects = (cls.subjects && cls.subjects.length > 0) ? cls.subjects : ['Bangla', 'English', 'Mathematics', 'General Science', 'ICT'];

    return `
      <div class="class-item-card">
        <div class="class-header-row">
          <div class="class-header-left">
            <div class="class-avatar-icon">
              <i class="fa-solid fa-graduation-cap"></i>
            </div>
            <div>
              <div class="class-title-text">${cls.name}</div>
              <div class="class-subtitle-text">${studentCount} Students</div>
            </div>
          </div>
          <div style="display:flex; gap:8px;">
            <button class="icon-action-btn" title="Edit" onclick="openAddClassModal('${cls.id}')" style="color:#4F46E5; border-color:#C7D2FE;"><i class="fa-solid fa-pencil"></i></button>
            <button class="icon-action-btn text-danger" title="Delete" onclick="deleteClass('${cls.id}')"><i class="fa-solid fa-trash-can"></i></button>
          </div>
        </div>

        <hr style="border:0; border-top:1px solid #F1F5F9; margin:14px 0 10px 0;">

        <div class="class-tags-line">
          <span class="class-row-label">Sections:</span>
          ${sections.map(sec => `<span class="section-pill">${sec}</span>`).join('')}
        </div>

        <div class="class-tags-line">
          <span class="class-row-label">Subjects:</span>
          ${subjects.map(sub => `<span class="subject-pill">${sub}</span>`).join('')}
        </div>
      </div>
    `;
  }).join('');
}

function openAddClassModal(classId = null) {
  const form = document.getElementById('classForm');
  form.reset();
  document.getElementById('classFormId').value = classId || '';

  if (classId) {
    const cls = state.classes.find(c => c.id === classId);
    if (cls) {
      document.getElementById('classModalTitle').innerText = 'Edit Class';
      document.getElementById('btnSaveClassSubmit').innerText = 'Update Class';
      document.getElementById('fmClassName').value = cls.name;
      activeClassSections = cls.sections && cls.sections.length > 0 ? [...cls.sections] : ['A', 'B', 'Morning'];
      activeClassSubjects = cls.subjects && cls.subjects.length > 0 ? [...cls.subjects] : ['Bangla', 'English', 'Mathematics', 'General Science', 'ICT'];
    }
  } else {
    document.getElementById('classModalTitle').innerText = 'Add Class';
    document.getElementById('btnSaveClassSubmit').innerText = 'Save Class';
    document.getElementById('fmClassName').value = '';
    activeClassSections = ['A', 'B'];
    activeClassSubjects = ['Bangla', 'English', 'Mathematics', 'General Science', 'ICT'];
  }

  renderClassChips();
  openModal('classModal');
}

function renderClassChips() {
  const secContainer = document.getElementById('classSectionsChips');
  if (secContainer) {
    secContainer.innerHTML = activeClassSections.map((sec, idx) => `
      <span class="chip-tag chip-section">
        <span>${sec}</span>
        <span class="chip-remove-btn" onclick="removeSectionChip(${idx})">&times;</span>
      </span>
    `).join('');
  }

  const subContainer = document.getElementById('classSubjectsChips');
  if (subContainer) {
    subContainer.innerHTML = activeClassSubjects.map((sub, idx) => `
      <span class="chip-tag chip-subject">
        <span>${sub}</span>
        <span class="chip-remove-btn" onclick="removeSubjectChip(${idx})">&times;</span>
      </span>
    `).join('');
  }
}

function addClassSectionChip() {
  const input = document.getElementById('fmNewSectionInput');
  if (!input) return;
  const val = input.value.trim();
  if (val && !activeClassSections.includes(val)) {
    activeClassSections.push(val);
    renderClassChips();
    input.value = '';
  }
}

function removeSectionChip(idx) {
  activeClassSections.splice(idx, 1);
  renderClassChips();
}

function addClassSubjectChip() {
  const input = document.getElementById('fmNewSubjectInput');
  if (!input) return;
  const val = input.value.trim();
  if (val && !activeClassSubjects.includes(val)) {
    activeClassSubjects.push(val);
    renderClassChips();
    input.value = '';
  }
}

function removeSubjectChip(idx) {
  activeClassSubjects.splice(idx, 1);
  renderClassChips();
}

function handleSaveClass(e) {
  e.preventDefault();
  const id = document.getElementById('classFormId').value;
  const name = document.getElementById('fmClassName').value.trim();
  if (!name) return;

  const sections = activeClassSections.length > 0 ? activeClassSections : ['A'];
  const subjects = activeClassSubjects.length > 0 ? activeClassSubjects : [];

  if (id) {
    const cls = state.classes.find(c => c.id === id);
    if (cls) {
      cls.name = name;
      cls.sections = sections;
      cls.subjects = subjects;
    }
  } else {
    state.classes.push({
      id: 'cls-' + Date.now(),
      name: name,
      sections: sections,
      subjects: subjects
    });
  }

  state.save();
  closeModal('classModal');
  renderClassesList();
  renderStudentClassFilterChips();
  renderStudentsList();
}

function deleteClass(classId) {
  if (confirm('আপনি কি এই শ্রেণি মুছে ফেলতে চান?')) {
    state.classes = state.classes.filter(c => c.id !== classId);
    state.save();
    renderClassesList();
    renderStudentClassFilterChips();
    renderStudentsList();
  }
}

// ==================== STUDENTS VIEW & FILTERS ====================
function renderStudentClassFilterChips() {
  const container = document.getElementById('studentClassChips');
  if (!container) return;

  const classNames = ['All', ...state.classes.map(c => c.name)];
  if (!classNames.includes(state.studentClassFilter)) {
    state.studentClassFilter = 'All';
  }

  container.innerHTML = classNames.map(name => {
    const isActive = state.studentClassFilter === name;
    const label = name === 'All' ? state.t('filter_all') : name;
    return `
      <button class="chip ${isActive ? 'active' : ''}" data-class="${name}" onclick="setStudentClassFilter('${name}')">
        ${label}
      </button>
    `;
  }).join('');
}

function setStudentStatusFilter(status) {
  state.studentStatusFilter = status;
  document.querySelectorAll('#studentStatusChips .chip').forEach(c => {
    c.classList.toggle('active', c.getAttribute('data-status') === status);
  });
  renderStudentsList();
}

function setStudentClassFilter(className) {
  state.studentClassFilter = className;
  document.querySelectorAll('#studentClassChips .chip').forEach(c => {
    c.classList.toggle('active', c.getAttribute('data-class') === className);
  });
  renderStudentsList();
}

function clearStudentSearch() {
  document.getElementById('studentSearchInput').value = '';
  renderStudentsList();
}

function renderStudentsList() {
  const listEl = document.getElementById('studentsList');
  if (!listEl) return;
  const query = (document.getElementById('studentSearchInput')?.value || '').trim().toLowerCase();

  const filtered = state.students.filter(s => {
    // 1. Query Filter
    if (query) {
      const matchName = (s.name || '').toLowerCase().includes(query);
      const matchRoll = (s.rollNumber || '').toLowerCase().includes(query);
      const matchFather = (s.fatherName || '').toLowerCase().includes(query);
      const matchPhone = (s.fatherPhone || '').toLowerCase().includes(query);
      const matchStdPhone = (s.studentPhone || '').toLowerCase().includes(query);
      if (!matchName && !matchRoll && !matchFather && !matchPhone && !matchStdPhone) return false;
    }
    // 2. Class Filter
    if (state.studentClassFilter !== 'All' && s.className !== state.studentClassFilter) {
      return false;
    }
    // 3. Status Filter
    const due = state.getStudentDue(s);
    const advance = state.getStudentAdvance(s);
    if (state.studentStatusFilter === 'due' && due <= 0) return false;
    if (state.studentStatusFilter === 'paid' && (due > 0 || advance > 0)) return false;
    if (state.studentStatusFilter === 'advance' && advance <= 0) return false;

    return true;
  });

  if (filtered.length === 0) {
    if (state.students.length === 0) {
      listEl.innerHTML = `
        <div style="text-align:center; padding:36px 20px; color:var(--text-muted);">
          <i class="fa-solid fa-user-slash" style="font-size:36px; opacity:0.3; margin-bottom:10px;"></i>
          <p style="font-size:14px; font-weight:600;">কোনো শিক্ষার্থী সংরক্ষিত নেই</p>
          <button class="btn btn-primary mt-3" style="font-size:13px; padding:8px 18px; border-radius:20px; background:#4f46e5; color:#fff;" onclick="restoreDefaultStudents(true)">
            <i class="fa-solid fa-rotate mr-1"></i> ১৭ জন শিক্ষার্থী লোড করুন
          </button>
        </div>
      `;
    } else {
      listEl.innerHTML = `
        <div style="text-align:center; padding:36px 20px; color:var(--text-muted);">
          <i class="fa-solid fa-user-slash" style="font-size:36px; opacity:0.3; margin-bottom:10px;"></i>
          <p style="font-size:14px; font-weight:600;">কোনো শিক্ষার্থী পাওয়া যায়নি</p>
        </div>
      `;
    }
    return;
  }

  listEl.innerHTML = filtered.map(s => {
    const due = state.getStudentDue(s);
    const advance = state.getStudentAdvance(s);
    const initial = s.name ? s.name.trim().charAt(0).toUpperCase() : '?';

    let badgeHtml = '';
    if (due > 0) {
      badgeHtml = `<span class="badge-pill badge-due">${state.t('due')}: ৳ ${due.toLocaleString('en-IN')}</span>`;
    } else if (advance > 0) {
      badgeHtml = `<span class="badge-pill badge-advance">${state.t('advance')}: ৳ ${advance.toLocaleString('en-IN')}</span>`;
    } else {
      badgeHtml = `<span class="badge-pill badge-paid">${state.t('paid_status')}</span>`;
    }

    return `
      <div class="student-item-card" onclick="openStudentDetailModal('${s.id}')">
        <div class="student-avatar">${initial}</div>
        <div class="student-main-info">
          <div class="student-name">${s.name}</div>
          <div class="student-meta">${s.className} · Roll ${s.rollNumber} · Sec ${s.section || '—'}</div>
        </div>
        <div class="student-right-info">
          <div class="student-fee">৳ ${Number(s.monthlyFee).toLocaleString('en-IN')}</div>
          ${badgeHtml}
        </div>
      </div>
    `;
  }).join('');
}

// ==================== REQUIREMENT 4: STUDENT DETAIL & DIRECT COMMUNICATION (Image 2) ====================
function openStudentDetailModal(studentId) {
  state.selectedStudentId = studentId;
  renderStudentDetail(studentId);
  openModal('studentDetailModal');
}

function formatDetailDate(dateStr) {
  if (!dateStr) return '—';
  try {
    const d = new Date(dateStr);
    if (isNaN(d.getTime())) return dateStr;
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return `${months[d.getMonth()]} ${d.getDate()}, ${d.getFullYear()}`;
  } catch(e) {
    return dateStr;
  }
}

function renderStudentDetail(studentId) {
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;

  document.getElementById('studentDetailName').innerText = student.name;
  const due = state.getStudentDue(student);
  const advance = state.getStudentAdvance(student);
  const expected = state.getTotalExpected(student);
  const paid = state.getTotalPaid(student.id);
  const payments = state.payments.filter(p => p.studentId === student.id).sort((a, b) => new Date(b.paymentDate) - new Date(a.paymentDate));

  const effectivePhone = student.fatherPhone || student.studentPhone || '';
  const initial = (student.name || 'S').trim().charAt(0).toUpperCase();

  const body = document.getElementById('studentDetailBody');
  body.innerHTML = `
    <!-- 1. Student Profile Card (Matching Image 5) -->
    <div class="student-profile-card">
      <div class="profile-top-row">
        <div class="profile-avatar-circle">${initial}</div>
        <div>
          <div class="profile-name-text">${student.name}</div>
          <div class="profile-meta-text">Class ${student.className.replace('Class ', '')} · Roll ${student.rollNumber} · Sec ${student.section || 'A'}</div>
        </div>
      </div>

      <hr style="border:0; border-top:1px solid #F1F5F9; margin:16px 0;">

      <div class="profile-detail-item">
        <i class="fa-solid fa-dollar-sign"></i>
        <span>Monthly Fee: <strong class="profile-detail-val">৳${Number(student.monthlyFee).toFixed(2)}</strong></span>
      </div>

      ${student.address ? `
      <div class="profile-detail-item">
        <i class="fa-solid fa-house"></i>
        <span>Address: <strong class="profile-detail-val">${student.address}</strong></span>
      </div>` : ''}

      <div class="profile-detail-item">
        <i class="fa-regular fa-calendar-days"></i>
        <span>Admission Date: <strong class="profile-detail-val">${formatDetailDate(student.admissionDate)}</strong></span>
      </div>

      <div class="profile-detail-item">
        <i class="fa-solid fa-users"></i>
        <span>Guardian Name: <strong class="profile-detail-val">${student.fatherName || '—'}</strong></span>
      </div>

      <div class="profile-detail-item">
        <i class="fa-solid fa-phone"></i>
        <span>Guardian Phone Number: <strong class="profile-detail-val">${student.fatherPhone || '—'}</strong></span>
      </div>

      ${student.studentPhone ? `
      <div class="profile-detail-item">
        <i class="fa-solid fa-mobile-screen"></i>
        <span>Student Phone Number: <strong class="profile-detail-val">${student.studentPhone}</strong></span>
      </div>` : ''}
    </div>

    <!-- 2. Direct Communication Card (Matching Image 5) -->
    <div class="direct-comm-card" style="margin-top:14px; background:white; border:1px solid #E2E8F0; border-radius:20px; padding:16px;">
      <div class="direct-comm-header" style="font-size:15px; font-weight:800; color:#1E293B; display:flex; align-items:center; gap:8px;">
        <i class="fa-regular fa-comment-dots" style="color:#2563EB; font-size:18px;"></i>
        <span>Direct Communication</span>
      </div>
      <div class="direct-comm-buttons" style="margin-top:14px; display:flex; justify-content:space-around; align-items:center;">
        <!-- 1. Call -->
        <button class="direct-comm-item comm-call" onclick="callDirect('${effectivePhone}')" title="Call">
          <div class="direct-comm-circle">
            <i class="fa-solid fa-phone"></i>
          </div>
          <span>Call</span>
        </button>

        <!-- 2. SMS -->
        <button class="direct-comm-item comm-sms" onclick="smsDirect('${effectivePhone}', '${student.id}')" title="SMS">
          <div class="direct-comm-circle">
            <i class="fa-solid fa-comment-dots"></i>
          </div>
          <span>SMS</span>
        </button>

        <!-- 3. WhatsApp -->
        <button class="direct-comm-item comm-whatsapp" onclick="whatsappDirect('${effectivePhone}', '${student.id}')" title="WhatsApp">
          <div class="direct-comm-circle">
            <i class="fa-brands fa-whatsapp"></i>
          </div>
          <span>WhatsApp</span>
        </button>

        <!-- 4. Telegram -->
        <button class="direct-comm-item comm-telegram" onclick="telegramDirect('${effectivePhone}')" title="Telegram">
          <div class="direct-comm-circle">
            <i class="fa-solid fa-paper-plane"></i>
          </div>
          <span>Telegram</span>
        </button>

        <!-- 5. Save Contact -->
        <button class="direct-comm-item comm-save" onclick="saveContactDirect('${student.id}')" title="Save">
          <div class="direct-comm-circle">
            <i class="fa-regular fa-address-book"></i>
          </div>
          <span>Save</span>
        </button>
      </div>
    </div>

    <!-- 3. 4-Stats Grid (2x2) (Matching Image 5) -->
    <div class="stats-grid" style="margin-top:14px; display:grid; grid-template-columns:1fr 1fr; gap:12px;">
      <div class="stat-card" style="background:white; border-radius:18px; padding:14px 16px; border:1px solid #E2E8F0;">
        <div class="stat-info">
          <div class="stat-label" style="font-size:12px; color:#64748B; font-weight:600;">Total Expected</div>
          <div class="stat-value" style="font-size:18px; font-weight:800; color:#4F46E5; margin-top:4px;">৳${expected.toFixed(2)}</div>
        </div>
      </div>
      <div class="stat-card" style="background:white; border-radius:18px; padding:14px 16px; border:1px solid #E2E8F0;">
        <div class="stat-info">
          <div class="stat-label" style="font-size:12px; color:#64748B; font-weight:600;">Total Paid</div>
          <div class="stat-value" style="font-size:18px; font-weight:800; color:#10B981; margin-top:4px;">৳${paid.toFixed(2)}</div>
        </div>
      </div>
      <div class="stat-card" style="background:white; border-radius:18px; padding:14px 16px; border:1px solid #E2E8F0;">
        <div class="stat-info">
          <div class="stat-label" style="font-size:12px; color:#64748B; font-weight:600;">Due</div>
          <div class="stat-value" style="font-size:18px; font-weight:800; color:#EF4444; margin-top:4px;">৳${due.toFixed(2)}</div>
        </div>
      </div>
      <div class="stat-card" style="background:white; border-radius:18px; padding:14px 16px; border:1px solid #E2E8F0;">
        <div class="stat-info">
          <div class="stat-label" style="font-size:12px; color:#64748B; font-weight:600;">Advance</div>
          <div class="stat-value" style="font-size:18px; font-weight:800; color:#06B6D4; margin-top:4px;">৳${advance.toFixed(2)}</div>
        </div>
      </div>
    </div>

    <!-- 4. Payment History (Matching Image 5) -->
    <div style="margin-top:20px; margin-bottom:80px;">
      <div style="font-size:16px; font-weight:800; color:#1E293B; margin-bottom:10px;">Payment History</div>
      <div class="payment-history-list">
        ${payments.length === 0 ? `<div style="background:white; border:1px solid #E2E8F0; border-radius:14px; color:var(--text-muted); font-size:13px; text-align:center; padding:18px;">No payments recorded yet</div>` : payments.map(p => `
          <div style="background:white; border:1px solid #E2E8F0; padding:12px 14px; border-radius:14px; margin-bottom:8px; display:flex; justify-content:space-between; align-items:center;">
            <div>
              <div style="font-weight:800; font-size:15px; color:#10B981;">৳ ${Number(p.amount).toLocaleString('en-IN', { minimumFractionDigits: 2 })}</div>
              <div style="font-size:12px; color:#64748B; margin-top:2px;">${p.receiptNo} · ${p.paymentDate} · ${p.method} (${p.forMonth})</div>
              ${p.note ? `<div style="font-size:11px; color:#334155; margin-top:2px;">Note: ${p.note}</div>` : ''}
            </div>
            <div style="display:flex; gap:6px;">
              <button class="icon-action-btn" title="View / Print Receipt" onclick="showReceiptModal('${p.id}')" style="color:#4F46E5;"><i class="fa-solid fa-receipt"></i></button>
              <button class="icon-action-btn text-danger" title="Delete" onclick="deletePaymentRecord('${p.id}')"><i class="fa-solid fa-trash-can"></i></button>
            </div>
          </div>
        `).join('')}
      </div>
    </div>

    <!-- 5. Floating Collect Payment Button (Matching Image 5) -->
    <button class="btn-floating-collect" onclick="openCollectPaymentForStudent('${student.id}')">
      <i class="fa-solid fa-money-bill-wave"></i> Collect Payment
    </button>
  `;
}

// Attendance Increment / Decrement
function updateStudentAttendance(studentId, delta) {
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;
  if (!student.attendance) student.attendance = {};
  const curMonthKey = new Date().toISOString().substring(0, 7);
  const cur = student.attendance[curMonthKey] || 0;
  student.attendance[curMonthKey] = Math.max(0, cur + delta);
  state.save();
  renderStudentDetail(studentId);
}

// ==================== DIRECT COMMUNICATION ACTIONS (Image 2 Handlers) ====================
function cleanPhone(raw) {
  if (!raw) return '';
  let clean = raw.replace(/[^\d+]/g, '');
  if (clean.startsWith('01')) clean = '88' + clean;
  else if (clean.startsWith('+8801')) clean = clean.substring(1);
  return clean;
}

function callDirect(phone) {
  if (!phone) return alert(state.t('no_phone_msg'));
  window.location.href = `tel:${phone}`;
}

function smsDirect(phone, studentId) {
  if (!phone) return alert(state.t('no_phone_msg'));
  const student = state.students.find(s => s.id === studentId);
  const due = student ? state.getStudentDue(student) : 0;
  const text = due > 0
    ? `সম্মানিত অভিভাবক, আপনার সন্তান ${student.name} (শ্রেণি: ${student.className}, রোল: ${student.rollNumber})-এর টিউশন ফি বাবদ ৳${due.toLocaleString('en-IN')} বকেয়া রয়েছে। বিনীত - ABS Hisab Manager`
    : `সম্মানিত অভিভাবক, ${student ? student.name : 'শিক্ষার্থী'} সংক্রান্ত তথ্য। বিনীত - ABS Hisab Manager`;

  window.location.href = `sms:${phone}?body=${encodeURIComponent(text)}`;
}

function whatsappDirect(phone, studentId) {
  if (!phone) return alert(state.t('no_phone_msg'));
  const student = state.students.find(s => s.id === studentId);
  const due = student ? state.getStudentDue(student) : 0;
  const text = due > 0
    ? `আসসালামু আলাইকুম। আপনার সন্তান ${student.name} (শ্রেণি: ${student.className}, রোল: ${student.rollNumber})-এর টিউশন ফি বাবদ ৳${due.toLocaleString('en-IN')} বকেয়া রয়েছে। - ABS Hisab Manager`
    : `আসসালামু আলাইকুম। ${student ? student.name : 'শিক্ষার্থী'} সংক্রান্ত তথ্য। - ABS Hisab Manager`;

  const clean = cleanPhone(phone);
  window.open(`https://wa.me/${clean}?text=${encodeURIComponent(text)}`, '_blank');
}

function telegramDirect(phone) {
  if (!phone) return alert(state.t('no_phone_msg'));
  const clean = cleanPhone(phone);
  window.open(`https://t.me/+${clean.replace('+', '')}`, '_blank');
}

function saveContactDirect(studentId) {
  const s = state.students.find(x => x.id === studentId);
  if (!s) return;
  const phone = s.fatherPhone || s.studentPhone || '';
  const text = `Student: ${s.name}\nClass: ${s.className} (Roll: ${s.rollNumber}, Sec: ${s.section})\nGuardian: ${s.fatherName}\nPhone: ${phone}\nAddress: ${s.address || '—'}\nMonthly Fee: ৳${s.monthlyFee}`;

  if (navigator.clipboard) {
    navigator.clipboard.writeText(text).then(() => {
      alert('শিক্ষার্থীর কন্টাক্ট ও তথ্য কপি করা হয়েছে:\n\n' + text);
    });
  } else {
    alert('শিক্ষার্থীর তথ্য:\n\n' + text);
  }
}

// ==================== REQUIREMENT 3: ADD / EDIT STUDENT (Image 1 Style) ====================
function openAddStudentModal(studentId = null) {
  const form = document.getElementById('studentForm');
  form.reset();
  document.getElementById('studentFormId').value = studentId || '';

  renderStudentClassDropdownOptions();

  if (studentId) {
    const s = state.students.find(x => x.id === studentId);
    if (s) {
      document.getElementById('studentModalTitle').innerText = 'Edit Student';
      document.getElementById('btnSaveStudentSubmit').innerText = 'Update Student';
      document.getElementById('fmStudentName').value = s.name;
      document.getElementById('fmStudentRoll').value = s.rollNumber;
      document.getElementById('fmStudentFee').value = s.monthlyFee;
      document.getElementById('fmFatherName').value = s.fatherName || '';
      document.getElementById('fmFatherPhone').value = s.fatherPhone || '';
      document.getElementById('fmStudentPhone').value = s.studentPhone || '';
      document.getElementById('fmStudentAddress').value = s.address || '';
      document.getElementById('fmAdmissionDate').value = s.admissionDate || '';
      
      document.getElementById('fmStudentClass').value = s.className;
      onStudentClassChanged(s.section);
    }
  } else {
    document.getElementById('studentModalTitle').innerText = 'Add Student';
    document.getElementById('btnSaveStudentSubmit').innerText = 'Save Student';
    document.getElementById('fmAdmissionDate').value = new Date().toISOString().split('T')[0];
    onStudentClassChanged();
  }

  openModal('studentModal');
}

function renderStudentClassDropdownOptions() {
  const classSelect = document.getElementById('fmStudentClass');
  if (!classSelect) return;

  if (state.classes.length === 0) {
    state.classes = defaultClasses;
    state.save();
  }

  classSelect.innerHTML = state.classes.map(c => `
    <option value="${c.name}">${c.name}</option>
  `).join('');
}

function onStudentClassChanged(selectedSection = null) {
  const classSelect = document.getElementById('fmStudentClass');
  const sectionSelect = document.getElementById('fmStudentSection');
  if (!classSelect || !sectionSelect) return;

  const currentClass = state.classes.find(c => c.name === classSelect.value) || state.classes[0];
  const sections = (currentClass && currentClass.sections && currentClass.sections.length > 0)
    ? currentClass.sections
    : ['A', 'B'];

  sectionSelect.innerHTML = sections.map(sec => `
    <option value="${sec}">${sec}</option>
  `).join('');

  if (selectedSection && sections.includes(selectedSection)) {
    sectionSelect.value = selectedSection;
  }
}

function handleSaveStudent(e) {
  e.preventDefault();
  const id = document.getElementById('studentFormId').value;
  const name = document.getElementById('fmStudentName').value.trim();
  const className = document.getElementById('fmStudentClass').value;
  const rollNumber = document.getElementById('fmStudentRoll').value.trim();
  const section = document.getElementById('fmStudentSection').value;
  const monthlyFee = Number(document.getElementById('fmStudentFee').value) || 0;
  const fatherName = document.getElementById('fmFatherName').value.trim();
  const fatherPhone = document.getElementById('fmFatherPhone').value.trim();
  const studentPhone = (document.getElementById('fmStudentPhone')?.value || '').trim();
  const address = document.getElementById('fmStudentAddress').value.trim();
  const admissionDate = document.getElementById('fmAdmissionDate').value;

  if (!name || !rollNumber || !fatherPhone) {
    alert('অনুগ্রহ করে তারকাচিহ্নিত (*) সব প্রয়োজনীয় ঘর পূরণ করুন।');
    return;
  }

  if (id) {
    const s = state.students.find(x => x.id === id);
    if (s) {
      s.name = name;
      s.className = className;
      s.rollNumber = rollNumber;
      s.section = section;
      s.monthlyFee = monthlyFee;
      s.fatherName = fatherName;
      s.fatherPhone = fatherPhone;
      s.studentPhone = studentPhone;
      s.address = address;
      s.admissionDate = admissionDate;
    }
  } else {
    state.students.push({
      id: 'std-' + Date.now(),
      name,
      className,
      rollNumber,
      section,
      monthlyFee,
      fatherName,
      fatherPhone,
      studentPhone,
      address,
      admissionDate,
      attendance: {}
    });
  }

  state.save();
  closeModal('studentModal');
  renderStudentsList();
  renderDashboard();
  if (id && state.selectedStudentId === id) {
    renderStudentDetail(id);
  }
}

function editCurrentStudent() {
  closeModal('studentDetailModal');
  openAddStudentModal(state.selectedStudentId);
}

function deleteCurrentStudent() {
  if (confirm('আপনি কি এই শিক্ষার্থীর সম্পূর্ণ প্রোফাইল ও পেমেন্ট হিস্ট্রি ডিলিট করতে চান?')) {
    state.students = state.students.filter(s => s.id !== state.selectedStudentId);
    state.payments = state.payments.filter(p => p.studentId !== state.selectedStudentId);
    state.save();
    closeModal('studentDetailModal');
    renderStudentsList();
    renderDashboard();
  }
}

// ==================== PAYMENT COLLECTION (Cash / bKash / Nagad / Rocket) ====================
function openStudentPickerModal() {
  const list = document.getElementById('pickerStudentList');
  if (!list) return;

  if (state.students.length === 0) {
    alert('প্রথমে একজন শিক্ষার্থী যুক্ত করুন');
    return openAddStudentModal();
  }

  list.innerHTML = state.students.map(s => {
    const due = state.getStudentDue(s);
    return `
      <div class="student-item-card" onclick="selectStudentForPayment('${s.id}')">
        <div class="student-avatar">${s.name.charAt(0)}</div>
        <div class="student-main-info">
          <div class="student-name">${s.name}</div>
          <div class="student-meta">${s.className} · Roll ${s.rollNumber}</div>
        </div>
        <div class="student-right-info">
          <div class="student-fee">ফি: ৳ ${s.monthlyFee}</div>
          ${due > 0 ? `<span class="badge-pill badge-due">বাকি: ৳ ${due}</span>` : '<span class="badge-pill badge-paid">পরিশোধিত</span>'}
        </div>
      </div>
    `;
  }).join('');

  openModal('studentPickerModal');
}

function selectStudentForPayment(studentId) {
  closeModal('studentPickerModal');
  openCollectPaymentForStudent(studentId);
}

function openCollectPaymentForStudent(studentId) {
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;

  document.getElementById('paymentForm').reset();
  document.getElementById('pmStudentId').value = student.id;

  const due = state.getStudentDue(student);
  document.getElementById('pmStudentBadge').innerHTML = `
    <strong>${student.name}</strong> (${student.className} · Roll ${student.rollNumber})
    <div style="font-size:12px; margin-top:2px; color:${due > 0 ? 'var(--expense)' : 'var(--income)'}; font-weight:700;">
      বর্তমান বকেয়া: ৳ ${due.toLocaleString('en-IN')}
    </div>
  `;

  document.getElementById('pmAmount').value = due > 0 ? due : student.monthlyFee;
  document.getElementById('pmDate').value = new Date().toISOString().split('T')[0];
  document.getElementById('pmMonth').value = new Date().toISOString().substring(0, 7);

  openModal('collectPaymentModal');
}

function handleSavePayment(e) {
  e.preventDefault();
  const studentId = document.getElementById('pmStudentId').value;
  const amount = Number(document.getElementById('pmAmount').value);
  const method = document.getElementById('pmMethod').value;
  const forMonth = document.getElementById('pmMonth').value;
  const paymentDate = document.getElementById('pmDate').value;
  const note = document.getElementById('pmNote').value.trim();
  const giveReceipt = document.getElementById('pmGiveReceipt').checked;

  if (!studentId || !amount) return;
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;

  const receiptNo = 'REC-' + forMonth.replace('-', '') + '-' + Math.floor(100 + Math.random() * 900);

  const payment = {
    id: 'pay-' + Date.now(),
    studentId,
    amount,
    method,
    forMonth,
    paymentDate,
    note,
    receiptGiven: giveReceipt,
    receiptNo
  };

  state.payments.push(payment);

  // Automatically record Income transaction
  state.transactions.push({
    id: 'txn-' + Date.now(),
    type: 'income',
    amount,
    category: 'Tuition',
    date: paymentDate,
    note: `${student.name} (${student.className}) - ${forMonth} Fee [${method}]`,
    studentId,
    paymentMethod: method
  });

  state.save();
  closeModal('collectPaymentModal');

  renderDashboard();
  renderStudentsList();
  renderTransactionsList();
  if (state.selectedStudentId === studentId) {
    renderStudentDetail(studentId);
  }

  if (giveReceipt) {
    setTimeout(() => printMoneyReceipt(payment.id), 300);
  }
}

function deletePaymentRecord(paymentId) {
  if (confirm('আপনি কি এই পেমেন্ট রেকর্ড মুছে ফেলতে চান?')) {
    state.payments = state.payments.filter(p => p.id !== paymentId);
    state.save();
    renderDashboard();
    renderStudentsList();
    if (state.selectedStudentId) renderStudentDetail(state.selectedStudentId);
  }
}

// ==================== TRANSACTIONS ====================
function setTxnTypeFilter(type) {
  state.txnTypeFilter = type;
  document.querySelectorAll('#txnFilterChips .chip').forEach(c => {
    c.classList.toggle('active', c.getAttribute('data-type') === type);
  });
  renderTransactionsList();
}

function renderTransactionsList() {
  const listEl = document.getElementById('fullTxnList');
  if (!listEl) return;

  const filtered = state.transactions.filter(t => {
    if (state.txnTypeFilter === 'all') return true;
    return t.type === state.txnTypeFilter;
  });

  const sorted = [...filtered].sort((a, b) => new Date(b.date) - new Date(a.date));

  if (sorted.length === 0) {
    listEl.innerHTML = `<div style="text-align:center; padding:36px; color:var(--text-muted);">কোনো লেনদেন রেকর্ড পাওয়া যায়নি</div>`;
    return;
  }

  listEl.innerHTML = sorted.map(t => renderTxnCardHtml(t)).join('');
}

function openAddTransactionModal(type = 'expense') {
  const form = document.getElementById('txnForm');
  form.reset();
  setTxnFormType(type);
  document.getElementById('txnDate').value = new Date().toISOString().split('T')[0];
  openModal('transactionModal');
}

function setTxnFormType(type) {
  document.getElementById('txnFormType').value = type;
  document.getElementById('txnTypeIncomeBtn').classList.toggle('active', type === 'income');
  document.getElementById('txnTypeExpenseBtn').classList.toggle('active', type === 'expense');

  const catSelect = document.getElementById('txnCategory');
  const cats = state.categories[type] || [];
  catSelect.innerHTML = cats.map(c => `<option value="${c}">${c}</option>`).join('');
}

function handleSaveTransaction(e) {
  e.preventDefault();
  const type = document.getElementById('txnFormType').value;
  const amount = Number(document.getElementById('txnAmount').value);
  const category = document.getElementById('txnCategory').value;
  const date = document.getElementById('txnDate').value;
  const paymentMethod = document.getElementById('txnMethod').value;
  const note = document.getElementById('txnNote').value.trim();

  if (!amount || !category) return;

  state.transactions.push({
    id: 'txn-' + Date.now(),
    type,
    amount,
    category,
    date,
    paymentMethod,
    note
  });

  state.save();
  closeModal('transactionModal');
  renderDashboard();
  renderTransactionsList();
}

function deleteTransaction(id) {
  if (confirm('আপনি কি এই লেনদেন মুছে ফেলতে চান?')) {
    state.transactions = state.transactions.filter(t => t.id !== id);
    state.save();
    renderDashboard();
    renderTransactionsList();
  }
}

// ==================== REPORTS (Daily, Weekly, Monthly, Yearly) ====================
function openReportModal(period = 'monthly') {
  state.currentReportPeriod = period;
  document.querySelectorAll('#reportPeriodTabs .seg-btn').forEach(b => {
    b.classList.toggle('active', b.getAttribute('data-period') === period);
  });
  renderReportContent();
  openModal('reportModal');
}

function renderReportContent() {
  const body = document.getElementById('reportBody');
  const anchor = state.reportAnchorDate;
  const period = state.currentReportPeriod;

  // Filter transactions in range
  const curMonth = anchor.getMonth();
  const curYear = anchor.getFullYear();
  const txns = state.transactions.filter(t => {
    const d = new Date(t.date);
    if (period === 'monthly') return d.getMonth() === curMonth && d.getFullYear() === curYear;
    if (period === 'yearly') return d.getFullYear() === curYear;
    return true;
  });

  const income = txns.filter(t => t.type === 'income').reduce((s, t) => s + Number(t.amount), 0);
  const expense = txns.filter(t => t.type === 'expense').reduce((s, t) => s + Number(t.amount), 0);
  const net = income - expense;

  const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  const label = period === 'monthly' ? `${monthNames[curMonth]} ${curYear}` : `${curYear}`;

  body.innerHTML = `
    <div style="display:flex; justify-content:space-between; align-items:center; background:var(--background); padding:12px; border-radius:var(--radius-md);">
      <button class="icon-action-btn" onclick="shiftReportPeriod(-1)"><i class="fa-solid fa-chevron-left"></i></button>
      <strong>${label}</strong>
      <button class="icon-action-btn" onclick="shiftReportPeriod(1)"><i class="fa-solid fa-chevron-right"></i></button>
    </div>

    <div class="stats-grid mt-3">
      <div class="stat-card">
        <div class="stat-info">
          <div class="stat-label">মোট আয়</div>
          <div class="stat-value" style="color:var(--income)">৳ ${income.toLocaleString('en-IN')}</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <div class="stat-label">মোট ব্যয়</div>
          <div class="stat-value" style="color:var(--expense)">৳ ${expense.toLocaleString('en-IN')}</div>
        </div>
      </div>
    </div>

    <div class="balance-card mt-3" style="padding:18px;">
      <div class="balance-sub">নিট লাভ / ক্ষতি</div>
      <div class="balance-amount" style="font-size:26px;">৳ ${net.toLocaleString('en-IN')}</div>
    </div>

    <div class="box-title mt-4">লেনদেনের তালিকা (${txns.length})</div>
    <div class="transactions-list mt-2">
      ${txns.map(t => renderTxnCardHtml(t)).join('')}
    </div>
  `;
}

function shiftReportPeriod(dir) {
  state.reportAnchorDate = new Date(state.reportAnchorDate.getFullYear(), state.reportAnchorDate.getMonth() + dir, 1);
  renderReportContent();
}

// ==================== MONEY RECEIPT MODAL & VOUCHER (Matching Image 7) ====================
let currentReceiptPaymentId = null;

function showReceiptModal(paymentId) {
  const payment = state.payments.find(p => p.id === paymentId);
  if (!payment) return;
  const student = state.students.find(s => s.id === payment.studentId) || { name: 'Student', className: '—', rollNumber: '—', section: '—' };
  currentReceiptPaymentId = paymentId;

  const due = state.getStudentDue(student);
  const totalPaid = state.getTotalPaid(student.id);

  const container = document.getElementById('receiptModalBody');
  if (container) {
    container.innerHTML = `
      <div id="printableReceiptArea" style="background:white; border:2px solid #E2E8F0; border-radius:18px; padding:24px; color:#1E293B; font-family:inherit; max-width:550px; margin:0 auto; box-shadow:0 4px 20px rgba(0,0,0,0.05);">
        <!-- Header -->
        <div style="text-align:center; border-bottom:2px dashed #CBD5E1; padding-bottom:14px; margin-bottom:16px;">
          <h2 style="margin:0; font-size:22px; font-weight:800; color:#4F46E5;">ABS Hisab Manager</h2>
          <div style="font-size:12px; color:#64748B; margin-top:2px;">Private Coaching & Academic Management</div>
          <div style="display:inline-block; background:#EEF2FF; color:#4F46E5; font-size:12px; font-weight:800; padding:4px 14px; border-radius:20px; margin-top:8px;">
            MONEY RECEIPT (মানি রিসিট)
          </div>
        </div>

        <!-- Info Meta Grid -->
        <table style="width:100%; font-size:13px; line-height:1.8; margin-bottom:14px;">
          <tr>
            <td><strong style="color:#64748B;">Receipt No:</strong></td>
            <td style="text-align:right; font-weight:700; color:#0F172A;">${payment.receiptNo}</td>
          </tr>
          <tr>
            <td><strong style="color:#64748B;">Payment Date:</strong></td>
            <td style="text-align:right; font-weight:600;">${payment.paymentDate}</td>
          </tr>
          <tr>
            <td><strong style="color:#64748B;">Student Name:</strong></td>
            <td style="text-align:right; font-weight:800; color:#1E293B; font-size:14px;">${student.name}</td>
          </tr>
          <tr>
            <td><strong style="color:#64748B;">Class & Roll:</strong></td>
            <td style="text-align:right; font-weight:600;">${student.className} · Roll ${student.rollNumber} (${student.section || 'A'})</td>
          </tr>
          <tr>
            <td><strong style="color:#64748B;">For Month:</strong></td>
            <td style="text-align:right; font-weight:700; color:#4F46E5;">${payment.forMonth}</td>
          </tr>
          <tr>
            <td><strong style="color:#64748B;">Payment Method:</strong></td>
            <td style="text-align:right; font-weight:600;">${payment.method}</td>
          </tr>
          ${payment.note ? `
          <tr>
            <td><strong style="color:#64748B;">Note:</strong></td>
            <td style="text-align:right; color:#475569;">${payment.note}</td>
          </tr>` : ''}
        </table>

        <!-- Paid Amount Box -->
        <div style="background:#F0FDF4; border:1.5px solid #86EFAC; border-radius:14px; padding:14px 18px; display:flex; justify-content:space-between; align-items:center; margin:16px 0;">
          <div>
            <div style="font-size:12px; font-weight:700; color:#166534;">Amount Paid (পরিশোধিত অর্থ)</div>
            <div style="font-size:11px; color:#15803D; margin-top:2px;">Full / Partial Tuition Fee</div>
          </div>
          <div style="font-size:22px; font-weight:900; color:#15803D;">
            ৳ ${Number(payment.amount).toLocaleString('en-IN', { minimumFractionDigits: 2 })}
          </div>
        </div>

        <!-- Balance Status -->
        <div style="display:flex; justify-content:space-between; font-size:12px; color:#64748B; padding:6px 4px; border-bottom:1px solid #F1F5F9; margin-bottom:28px;">
          <span>Total Paid so far: <strong>৳${totalPaid.toLocaleString('en-IN')}</strong></span>
          <span>Remaining Due: <strong style="color:${due > 0 ? '#EF4444' : '#10B981'};">৳${due.toLocaleString('en-IN')}</strong></span>
        </div>

        <!-- Signatures -->
        <div style="display:flex; justify-content:space-between; font-size:12px; color:#64748B; margin-top:36px; padding:0 10px;">
          <div style="text-align:center; border-top:1px solid #94A3B8; padding-top:6px; min-width:110px;">
            Student / Guardian
          </div>
          <div style="text-align:center; border-top:1px solid #94A3B8; padding-top:6px; min-width:110px;">
            Authorized Signature
          </div>
        </div>
      </div>
    `;
  }

  openModal('moneyReceiptModal');
}

function printMoneyReceipt(paymentId) {
  showReceiptModal(paymentId);
}

function triggerReceiptPrint() {
  const content = document.getElementById('printableReceiptArea');
  if (!content) return;
  const printArea = document.getElementById('printArea');
  if (printArea) {
    printArea.innerHTML = content.outerHTML;
  }
  window.print();
}

// ==================== PRINT FULL STUDENT STATEMENT (A4) ====================
function printStudentFullStatement() {
  if (!state.selectedStudentId) return;
  const s = state.students.find(x => x.id === state.selectedStudentId);
  if (!s) return;

  const expected = state.getTotalExpected(s);
  const paid = state.getTotalPaid(s.id);
  const due = state.getStudentDue(s);
  const advance = state.getStudentAdvance(s);
  const payments = state.payments.filter(p => p.studentId === s.id).sort((a, b) => new Date(a.paymentDate) - new Date(b.paymentDate));
  const totalClasses = Object.values(s.attendance || {}).reduce((a, b) => a + b, 0);

  const printArea = document.getElementById('printArea');
  printArea.innerHTML = `
    <div style="font-family:Arial,sans-serif; max-width:800px; margin:0 auto; padding:30px; color:#0f172a;">
      <div style="text-align:center; margin-bottom:18px;">
        <h1 style="color:#4f46e5; margin:0;">ABS Hisab Manager</h1>
        <h3 style="margin:4px 0 0 0; color:#475569;">STUDENT FINANCIAL STATEMENT & LEDGER</h3>
      </div>
      <hr style="border:0; border-top:1px solid #cbd5e1; margin:16px 0;">

      <div style="display:flex; justify-content:space-between; font-size:13px; line-height:1.8;">
        <div>
          <div><strong>Student:</strong> ${s.name}</div>
          <div><strong>Class:</strong> ${s.className}  |  <strong>Roll:</strong> ${s.rollNumber}  |  <strong>Sec:</strong> ${s.section || '—'}</div>
          <div><strong>Admission Date:</strong> ${s.admissionDate || '—'}</div>
          <div><strong>Address:</strong> ${s.address || '—'}</div>
        </div>
        <div style="text-align:right;">
          <div><strong>Monthly Fee:</strong> Tk ${Number(s.monthlyFee).toLocaleString('en-IN')}</div>
          <div><strong>Guardian:</strong> ${s.fatherName || '—'}</div>
          <div><strong>Guardian Mobile:</strong> ${s.fatherPhone || '—'}</div>
          <div><strong>Total Classes Attended:</strong> ${totalClasses}</div>
        </div>
      </div>

      <!-- Financial Overview Box -->
      <div style="background:#f1f5f9; padding:14px; border-radius:8px; margin:20px 0; display:flex; justify-content:space-around; text-align:center;">
        <div><div style="font-size:11px; color:#64748b;">Total Expected</div><strong style="font-size:15px;">Tk ${expected.toLocaleString('en-IN')}</strong></div>
        <div><div style="font-size:11px; color:#64748b;">Total Paid</div><strong style="font-size:15px; color:#10b981;">Tk ${paid.toLocaleString('en-IN')}</strong></div>
        <div><div style="font-size:11px; color:#64748b;">Current Due</div><strong style="font-size:15px; color:#ef4444;">Tk ${due.toLocaleString('en-IN')}</strong></div>
        <div><div style="font-size:11px; color:#64748b;">Advance</div><strong style="font-size:15px; color:#06b6d4;">Tk ${advance.toLocaleString('en-IN')}</strong></div>
      </div>

      <!-- Payments Table -->
      <h4 style="margin:20px 0 10px 0;">Itemized Payment Ledger</h4>
      <table style="width:100%; border-collapse:collapse; font-size:12px; text-align:left;">
        <thead>
          <tr style="background:#4f46e5; color:white;">
            <th style="padding:8px;">Receipt No</th>
            <th style="padding:8px;">Date</th>
            <th style="padding:8px;">For Month</th>
            <th style="padding:8px;">Method</th>
            <th style="padding:8px;">Note</th>
            <th style="padding:8px; text-align:right;">Amount (Tk)</th>
          </tr>
        </thead>
        <tbody>
          ${payments.map((p, i) => `
            <tr style="border-bottom:1px solid #e2e8f0; background:${i % 2 === 0 ? '#ffffff' : '#f8fafc'};">
              <td style="padding:8px;">${p.receiptNo}</td>
              <td style="padding:8px;">${p.paymentDate}</td>
              <td style="padding:8px;">${p.forMonth}</td>
              <td style="padding:8px;">${p.method}</td>
              <td style="padding:8px;">${p.note || '—'}</td>
              <td style="padding:8px; text-align:right; font-weight:bold;">${Number(p.amount).toLocaleString('en-IN')}</td>
            </tr>
          `).join('')}
        </tbody>
      </table>

      <div style="margin-top:60px; display:flex; justify-content:space-between; font-size:11px; color:#64748b;">
        <span>Generated on: ${new Date().toLocaleDateString()}</span>
        <span style="border-top:1px solid #334155; padding-top:4px;">Tutor / Authority Signature</span>
      </div>
    </div>
  `;

  window.print();
}

function printFinancialReportPdf() {
  window.print();
}

// ==================== CATEGORIES MANAGEMENT ====================
function openCategoriesModal() {
  switchCategoryTab('expense');
  openModal('categoriesModal');
}

function switchCategoryTab(type) {
  document.getElementById('catTabExpenseBtn').classList.toggle('active', type === 'expense');
  document.getElementById('catTabIncomeBtn').classList.toggle('active', type === 'income');
  renderCategoriesList(type);
}

function renderCategoriesList(type = 'expense') {
  const container = document.getElementById('categoriesListContainer');
  if (!container) return;
  const list = state.categories[type] || [];

  container.innerHTML = list.map(c => `
    <div style="background:var(--background); padding:10px 14px; border-radius:var(--radius-md); display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
      <span style="font-weight:600; font-size:13px;">${c}</span>
      ${list.length > 1 ? `<button class="icon-action-btn text-danger" onclick="deleteCategory('${type}', '${c}')"><i class="fa-solid fa-trash-can"></i></button>` : ''}
    </div>
  `).join('');
}

function addNewCategory() {
  const input = document.getElementById('newCategoryInput');
  const name = (input.value || '').trim();
  if (!name) return;
  const isIncome = document.getElementById('catTabIncomeBtn').classList.contains('active');
  const type = isIncome ? 'income' : 'expense';

  if (!state.categories[type].includes(name)) {
    state.categories[type].push(name);
    state.save();
    input.value = '';
    renderCategoriesList(type);
  }
}

function deleteCategory(type, name) {
  state.categories[type] = state.categories[type].filter(c => c !== name);
  state.save();
  renderCategoriesList(type);
}

// ==================== PIN LOCK & SECURITY ====================
function checkPinLock() {
  if (state.settings.pin && state.settings.pin.length === 4) {
    document.getElementById('pinLockOverlay').classList.add('show');
    state.enteredPin = '';
    updatePinDots();
  } else {
    document.getElementById('pinLockOverlay').classList.remove('show');
  }
}

function enterPinDigit(d) {
  if (state.enteredPin.length < 4) {
    state.enteredPin += d;
    updatePinDots();
    if (state.enteredPin.length === 4) {
      setTimeout(() => {
        if (state.enteredPin === state.settings.pin) {
          document.getElementById('pinLockOverlay').classList.remove('show');
          document.getElementById('pinErrorText').innerText = '';
        } else {
          document.getElementById('pinErrorText').innerText = 'ভুল পিন কোড (Incorrect PIN)';
          state.enteredPin = '';
          updatePinDots();
        }
      }, 100);
    }
  }
}

function deletePinDigit() {
  state.enteredPin = state.enteredPin.slice(0, -1);
  updatePinDots();
}

function updatePinDots() {
  const dots = document.querySelectorAll('#pinDotsRow .pin-dot');
  dots.forEach((dot, i) => {
    dot.classList.toggle('filled', i < state.enteredPin.length);
  });
}

function simulateBiometric() {
  document.getElementById('pinLockOverlay').classList.remove('show');
}

function openPinModal() {
  document.getElementById('newPinInput').value = '';
  document.getElementById('confirmPinInput').value = '';
  document.getElementById('btnRemovePin').style.display = state.settings.pin ? 'block' : 'none';
  openModal('pinSettingModal');
}

function saveNewPin() {
  const p1 = document.getElementById('newPinInput').value;
  const p2 = document.getElementById('confirmPinInput').value;
  if (p1.length !== 4) return alert('পিন অবশ্যই ৪ ডিজিটের হতে হবে');
  if (p1 !== p2) return alert('পিন দুটি মেলেনি');

  state.settings.pin = p1;
  state.save();
  closeModal('pinSettingModal');
  alert('পিন সফলভাবে সংরক্ষিত হয়েছে');
}

function removePinSecurity() {
  state.settings.pin = '';
  state.save();
  closeModal('pinSettingModal');
  alert('পিন লক নিষ্ক্রিয় করা হয়েছে');
}

// ==================== RESTORE 17 STUDENTS ====================
function restoreDefaultStudents(silent = false) {
  if (silent || confirm('আপনি কি ১৭ জন শিক্ষার্থীর মূল তালিকা রিস্টোর/সিঙ্ক করতে চান?')) {
    state.students = JSON.parse(JSON.stringify(defaultStudents));
    state.payments = [];
    state.transactions = [];
    localStorage.setItem(DB_VERSION_17_KEY, 'true');
    state.save();
    renderStudentsList();
    renderDashboard();
    renderClassesList();
    if (typeof renderStudentClassFilterChips === 'function') renderStudentClassFilterChips();
    if (typeof renderHajiraList === 'function') renderHajiraList();
    if (typeof renderBroadcastList === 'function') renderBroadcastList();
    if (!silent) alert('✅ ১৭ জন শিক্ষার্থীর ডাটা সফলভাবে রিস্টোর ও সিঙ্ক হয়েছে!');
  }
}

// ==================== DATA BACKUP (JSON EXPORT/IMPORT) ====================
function exportDataBackup() {
  const data = {
    version: 2,
    appName: 'ABS Hisab Manager-2',
    exportedAt: new Date().toISOString(),
    classes: state.classes,
    students: state.students,
    payments: state.payments,
    transactions: state.transactions,
    categories: state.categories,
    dailyAttendance: webDailyAttendance
  };

  const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `ABS_Hisab_Manager_2_Backup_${Date.now()}.json`;
  a.click();
  URL.revokeObjectURL(url);
}

function triggerImportBackup() {
  const input = document.getElementById('importFileInput');
  if (input) {
    input.value = '';
    input.click();
  }
}

function handleImportFile(e) {
  const file = e.target.files[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = (evt) => {
    try {
      const data = JSON.parse(evt.target.result);
      
      if (Array.isArray(data)) {
        state.students = data;
      } else {
        if (data.students) state.students = data.students;
        else if (data.studentList) state.students = data.studentList;
        else if (data.abs_students) state.students = data.abs_students;

        if (data.classes) state.classes = data.classes;
        else if (data.classList) state.classes = data.classList;

        if (data.payments) state.payments = data.payments;
        else if (data.fees) state.payments = data.fees;

        if (data.transactions) state.transactions = data.transactions;
        else if (data.history) state.transactions = data.history;

        if (data.categories) state.categories = data.categories;

        if (data.dailyAttendance) webDailyAttendance = data.dailyAttendance;
        else if (data.attendance) webDailyAttendance = data.attendance;
      }

      state.save();
      localStorage.setItem('abs_daily_attendance', JSON.stringify(webDailyAttendance));

      alert(`ডাটা রিস্টোর সম্পন্ন! মোট ${state.students.length} জন শিক্ষার্থী ও লেনদেনের তথ্য লোড হয়েছে।`);
      renderDashboard();
      renderClassesList();
      renderStudentClassFilterChips();
      renderStudentsList();
      renderTransactionsList();
    } catch (err) {
      console.error('Import Error:', err);
      alert('ভুল ফাইল ফরম্যাট! অনুগ্রহ করে সঠিক JSON ব্যাকআপ ফাইল নির্বাচন করুন।');
    }
  };
  reader.readAsText(file);
}

function confirmClearAllData() {
  if (confirm('আপনি কি নিশ্চিত যে সকল ডাটা মুছে ফেলতে চান? এটি আর ফেরানো যাবে না।')) {
    state.students = [];
    state.payments = [];
    state.transactions = [];
    state.save();
    renderDashboard();
    renderClassesList();
    renderStudentClassFilterChips();
    renderStudentsList();
    renderTransactionsList();
    alert('সকল ডাটা মুছে ফেলা হয়েছে');
  }
}

// ==================== MODAL HELPERS ====================
function openModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.add('show');
}

function closeModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.remove('show');
}

function closeAnyOpenModal() {
  const openBackdrop = document.querySelector('.modal-backdrop.show');
  if (openBackdrop) {
    openBackdrop.classList.remove('show');
    return true;
  }
  return false;
}

// Global backdrop click dismissal
document.addEventListener('click', (e) => {
  if (e.target && e.target.classList && e.target.classList.contains('modal-backdrop')) {
    e.target.classList.remove('show');
  }
});

// ESC key to close modal
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') {
    closeAnyOpenModal();
  }
});

// ==================== STUDENT HAJIRA (ATTENDANCE) MODULE (Image 1) ====================
let webHajiraDate = new Date().toISOString().split('T')[0];
let webDailyAttendance = {};

function initDailyAttendanceStorage() {
  try {
    const saved = localStorage.getItem('abs_daily_attendance');
    if (saved) webDailyAttendance = JSON.parse(saved);
  } catch(e) {
    webDailyAttendance = {};
  }
}
initDailyAttendanceStorage();

function formatDisplayDate(dateStr) {
  const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  const p = dateStr.split('-');
  if (p.length === 3) {
    const d = parseInt(p[2], 10);
    const m = months[parseInt(p[1], 10) - 1];
    return `${String(d).padStart(2, '0')} ${m} ${p[0]}`;
  }
  return dateStr;
}

function populateHajiraClassDropdowns() {
  const cSelect = document.getElementById('webHajiraClassFilter');
  const bSelect = document.getElementById('webBroadClassFilter');
  if (!cSelect || !bSelect) return;
  
  const classesSet = new Set(['Seven', 'Class 6', 'Class 7', 'Class 8', 'Class 9', 'Class 10']);
  (state.classes || []).forEach(c => { if (c.name) classesSet.add(c.name); });
  (state.students || []).forEach(s => { if (s.className) classesSet.add(s.className); });
  
  const curC = cSelect.value || 'All';
  const curB = bSelect.value || 'All';

  let html = '<option value="All">All Classes</option>';
  classesSet.forEach(c => {
    html += `<option value="${c}">${c}</option>`;
  });
  
  cSelect.innerHTML = html;
  bSelect.innerHTML = html;
  cSelect.value = curC;
  bSelect.value = curB;
}

function openHajiraModal() {
  populateHajiraClassDropdowns();
  const datePicker = document.getElementById('webHajiraDatePicker');
  if (datePicker) {
    datePicker.value = webHajiraDate;
    document.getElementById('webHajiraDateLabel').textContent = formatDisplayDate(webHajiraDate);
  }
  renderWebHajiraList();
  openModal('hajiraModal');
}

function onWebHajiraDateChange(val) {
  if (!val) return;
  webHajiraDate = val;
  document.getElementById('webHajiraDateLabel').textContent = formatDisplayDate(val);
  renderWebHajiraList();
}

function renderWebHajiraList() {
  const container = document.getElementById('webHajiraCardsContainer');
  if (!container) return;
  container.innerHTML = '';

  const cls = document.getElementById('webHajiraClassFilter').value;
  const sec = document.getElementById('webHajiraSectionFilter').value;

  // Filter students from state
  let list = state.students || [];
  if (list.length === 0) {
    // If empty, add Ahnaf & Asif Fuad demo
    list = [
      { id: 'std-101', name: 'Ahnaf', rollNumber: '01', className: 'Seven', section: 'A', studentPhone: '01710689846' },
      { id: 'std-102', name: 'Asif Fuad', rollNumber: '04', className: 'Seven', section: 'A', studentPhone: '01756346890' }
    ];
  }

  const filtered = list.filter(s => {
    const matchClass = (cls === 'All' || s.className === cls || (cls === 'Seven' && (s.className === 'Seven' || s.className === 'Class 7')));
    const matchSec = (sec === 'All' || s.section === sec);
    return matchClass && matchSec;
  });

  const dayRecords = webDailyAttendance[webHajiraDate] || {};
  let countP = 0, countA = 0, countL = 0, countLV = 0;

  filtered.forEach((s, idx) => {
    let st = dayRecords[s.id];
    if (!st) {
      st = (idx === 1) ? 'Absent' : 'Present'; // Demo default
    }

    if (st === 'Present') countP++;
    else if (st === 'Absent') countA++;
    else if (st === 'Late') countL++;
    else if (st === 'Leave') countLV++;

    const rollStr = String(s.rollNumber || (idx + 1)).padStart(2, '0');
    const phoneStr = s.studentPhone || s.fatherPhone || '01710689846';

    const card = document.createElement('div');
    card.style.cssText = 'background:#fff; border-radius:14px; padding:12px; border:1px solid #e2e8f0; box-shadow:0 1px 3px rgba(0,0,0,0.02);';
    
    let badgeBg = '#ecfdf5', badgeColor = '#065f46';
    if (st === 'Absent') { badgeBg = '#fef2f2'; badgeColor = '#991b1b'; }
    else if (st === 'Late') { badgeBg = '#fffbeb'; badgeColor = '#92400e'; }
    else if (st === 'Leave') { badgeBg = '#f0f9ff'; badgeColor = '#075985'; }

    card.innerHTML = `
      <div style="display:flex; align-items:center; gap:12px; margin-bottom:10px;">
        <div style="width:38px; height:38px; border-radius:50%; background:#e0edff; color:#1e60db; font-weight:700; font-size:13.5px; display:flex; align-items:center; justify-content:center; flex-shrink:0;">${rollStr}</div>
        <div style="flex:1;">
          <div style="font-size:14.5px; font-weight:700; color:#0f172a;">${s.name}</div>
          <div style="font-size:11.5px; color:#64748b; margin-top:1px;">Roll: ${rollStr} • ${phoneStr}</div>
        </div>
        <div style="font-size:11px; font-weight:600; padding:3px 9px; border-radius:8px; background:${badgeBg}; color:${badgeColor};">${st}</div>
      </div>
      <div style="display:grid; grid-template-columns:repeat(4, 1fr); gap:6px;">
        <button type="button" class="pill-btn ${st === 'Present' ? 'active-p' : ''}" onclick="setWebStudentStatus('${s.id}', 'Present')" style="border-radius:8px; padding:7px 2px; font-size:11px; font-weight:600; text-align:center; cursor:pointer; border:1px solid ${st === 'Present' ? '#059669' : '#bbf7d0'}; background:${st === 'Present' ? '#059669' : '#f0fdf4'}; color:${st === 'Present' ? '#fff' : '#166534'};">P (Present)</button>
        <button type="button" class="pill-btn ${st === 'Absent' ? 'active-a' : ''}" onclick="setWebStudentStatus('${s.id}', 'Absent')" style="border-radius:8px; padding:7px 2px; font-size:11px; font-weight:600; text-align:center; cursor:pointer; border:1px solid ${st === 'Absent' ? '#dc2626' : '#fecaca'}; background:${st === 'Absent' ? '#dc2626' : '#fef2f2'}; color:${st === 'Absent' ? '#fff' : '#991b1b'};">A (Absent)</button>
        <button type="button" class="pill-btn ${st === 'Late' ? 'active-l' : ''}" onclick="setWebStudentStatus('${s.id}', 'Late')" style="border-radius:8px; padding:7px 2px; font-size:11px; font-weight:600; text-align:center; cursor:pointer; border:1px solid ${st === 'Late' ? '#d97706' : '#fde68a'}; background:${st === 'Late' ? '#d97706' : '#fffbeb'}; color:${st === 'Late' ? '#fff' : '#92400e'};">L (Late)</button>
        <button type="button" class="pill-btn ${st === 'Leave' ? 'active-lv' : ''}" onclick="setWebStudentStatus('${s.id}', 'Leave')" style="border-radius:8px; padding:7px 2px; font-size:11px; font-weight:600; text-align:center; cursor:pointer; border:1px solid ${st === 'Leave' ? '#0284c7' : '#bae6fd'}; background:${st === 'Leave' ? '#0284c7' : '#f0f9ff'}; color:${st === 'Leave' ? '#fff' : '#075985'};">LV (Leave)</button>
      </div>
    `;
    container.appendChild(card);
  });

  document.getElementById('cntWebPres').textContent = countP;
  document.getElementById('cntWebAbs').textContent = countA;
  document.getElementById('cntWebLate').textContent = countL;
  document.getElementById('cntWebLeave').textContent = countLV;

  document.getElementById('webHajiraTotalLabel').textContent = `${filtered.length} Students Total`;
  document.getElementById('webHajiraBreakdownLabel').textContent = `Present: ${countP} | Absent: ${countA} | Late: ${countL}`;
}

function setWebStudentStatus(studentId, status) {
  if (!webDailyAttendance[webHajiraDate]) webDailyAttendance[webHajiraDate] = {};
  webDailyAttendance[webHajiraDate][studentId] = status;
  renderWebHajiraList();
}

function markAllWebHajira(status) {
  const cls = document.getElementById('webHajiraClassFilter').value;
  const sec = document.getElementById('webHajiraSectionFilter').value;

  if (!webDailyAttendance[webHajiraDate]) webDailyAttendance[webHajiraDate] = {};

  let list = state.students || [];
  if (list.length === 0) {
    list = [
      { id: 'std-101', className: 'Seven', section: 'A' },
      { id: 'std-102', className: 'Seven', section: 'A' }
    ];
  }

  list.forEach(s => {
    const matchClass = (cls === 'All' || s.className === cls || (cls === 'Seven' && (s.className === 'Seven' || s.className === 'Class 7')));
    const matchSec = (sec === 'All' || s.section === sec);
    if (matchClass && matchSec) {
      webDailyAttendance[webHajiraDate][s.id] = status;
    }
  });

  renderWebHajiraList();
}

function saveWebHajira() {
  localStorage.setItem('abs_daily_attendance', JSON.stringify(webDailyAttendance));
  const btnText = document.getElementById('btnWebHajiraSaveText');
  btnText.textContent = 'Saved Successfully!';
  setTimeout(() => {
    btnText.textContent = 'Saved (Save Again)';
  }, 1500);
}

// ==================== GROUP CALL, SMS & SOCIAL MODULE (Image 2) ====================
let webBroadSelectedAll = false;

function openGroupCallModal() {
  populateHajiraClassDropdowns();
  renderWebBroadList();
  openModal('groupCallModal');
}

function renderWebBroadList() {
  const container = document.getElementById('webBroadListContainer');
  if (!container) return;
  container.innerHTML = '';

  const cls = document.getElementById('webBroadClassFilter').value;
  const sec = document.getElementById('webBroadSectionFilter').value;

  let list = state.students || [];
  if (list.length === 0) {
    list = [
      { id: 'std-101', name: 'Ahnaf', rollNumber: '01', className: 'Seven', section: 'A', studentPhone: '01710689846' },
      { id: 'std-102', name: 'Asif Fuad', rollNumber: '04', className: 'Seven', section: 'A', studentPhone: '01756346890' }
    ];
  }

  const filtered = list.filter(s => {
    const matchClass = (cls === 'All' || s.className === cls || (cls === 'Seven' && (s.className === 'Seven' || s.className === 'Class 7')));
    const matchSec = (sec === 'All' || s.section === sec);
    return matchClass && matchSec;
  });

  filtered.forEach((s, idx) => {
    const rollStr = String(s.rollNumber || (idx + 1)).padStart(2, '0');
    const phoneStr = s.studentPhone || s.fatherPhone || '01710689846';

    const row = document.createElement('div');
    row.style.cssText = 'background:#fff; border-radius:12px; padding:10px 14px; display:flex; align-items:center; gap:12px; border:1px solid #eef2f6;';
    row.innerHTML = `
      <div style="display:flex; gap:8px;">
        <a href="tel:${phoneStr}" style="width:32px; height:32px; border-radius:50%; background:#ecfdf5; color:#10b981; display:flex; align-items:center; justify-content:center; text-decoration:none; font-size:13px;" title="কল দিন">
          <i class="fa-solid fa-phone"></i>
        </a>
        <button type="button" onclick="sendWebSingleSMS('${phoneStr}', '${s.name}')" style="width:32px; height:32px; border-radius:50%; background:#ecfdf5; color:#10b981; border:0; display:flex; align-items:center; justify-content:center; cursor:pointer; font-size:13px;" title="SMS">
          <i class="fa-solid fa-comment"></i>
        </button>
      </div>
      <div style="flex:1;">
        <div style="font-size:13.5px; font-weight:600; color:#1e293b;">${s.name} (Roll ${rollStr})</div>
        <div style="font-size:11.5px; color:#64748b;">${phoneStr}</div>
      </div>
      <div>
        <input type="checkbox" class="web-chk-select" value="${phoneStr}" data-name="${s.name}" data-roll="${rollStr}" ${idx === 0 ? 'checked' : ''} onchange="updateWebBroadCount()" style="width:20px; height:20px; cursor:pointer; accent-color:#1e60db;">
      </div>
    `;
    container.appendChild(row);
  });

  updateWebBroadCount();
}

function updateWebBroadCount() {
  const chks = document.querySelectorAll('.web-chk-select');
  const total = chks.length;
  let selected = 0;
  chks.forEach(c => { if (c.checked) selected++; });

  document.getElementById('webBroadSelectSummary').textContent = `${selected}/${total} selected`;
  document.getElementById('webBroadSmsCountBadge').textContent = selected;

  webBroadSelectedAll = (selected === total && total > 0);
  document.getElementById('webBroadSelectAllLabel').textContent = webBroadSelectedAll ? 'Deselect All' : 'Select All';
}

function toggleWebBroadAll() {
  const chks = document.querySelectorAll('.web-chk-select');
  webBroadSelectedAll = !webBroadSelectedAll;
  chks.forEach(c => c.checked = webBroadSelectedAll);
  updateWebBroadCount();
}

function getSelectedWebBroadStudents() {
  const chks = document.querySelectorAll('.web-chk-select:checked');
  const list = [];
  chks.forEach(c => {
    list.push({
      phone: c.value,
      name: c.getAttribute('data-name') || '',
      roll: c.getAttribute('data-roll') || ''
    });
  });
  return list;
}

function sendWebSingleSMS(phone, name) {
  const msg = document.getElementById('webBroadMsgInput').value.trim() || `সম্মানিত অভিভাবক (${name}-এর বিষয়ে বার্তা)`;
  window.location.href = `sms:${phone}?body=${encodeURIComponent(msg)}`;
}

function sendWebBulkSMS() {
  const selected = getSelectedWebBroadStudents();
  if (selected.length === 0) {
    alert('অনুগ্রহ করে অন্তত একজন শিক্ষার্থী নির্বাচন করুন!');
    return;
  }
  const msg = document.getElementById('webBroadMsgInput').value.trim() || 'সম্মানিত অভিভাবক, ABS Hisab Manager থেকে বার্তা।';
  const phones = selected.map(s => s.phone).join(',');
  const isApple = /(Mac|iPhone|iPod|iPad)/i.test(navigator.userAgent);
  const sep = isApple ? '&' : '?';
  window.location.href = `sms:${phones}${sep}body=${encodeURIComponent(msg)}`;
}

function sendWebBulkWa() {
  const selected = getSelectedWebBroadStudents();
  const msg = document.getElementById('webBroadMsgInput').value.trim() || 'সম্মানিত অভিভাবক, ABS Hisab Manager থেকে বার্তা।';
  if (selected.length === 1) {
    let p = selected[0].phone.replace(/[^0-9]/g, '');
    if (p.startsWith('01')) p = '88' + p;
    window.open(`https://api.whatsapp.com/send?phone=${p}&text=${encodeURIComponent(msg)}`, '_blank');
  } else if (navigator.share) {
    navigator.share({ title: 'ABS Broadcast', text: msg }).catch(() => {});
  } else {
    window.open(`https://api.whatsapp.com/send?text=${encodeURIComponent(msg)}`, '_blank');
  }
}

function sendWebBulkTelegram() {
  const msg = document.getElementById('webBroadMsgInput').value.trim() || 'সম্মানিত অভিভাবক, ABS Hisab Manager থেকে বার্তা।';
  window.open(`https://t.me/share/url?url=&text=${encodeURIComponent(msg)}`, '_blank');
}

function openWebRapidCall() {
  const selected = getSelectedWebBroadStudents();
  if (selected.length === 0) {
    alert('কল করার জন্য অন্তত একজন শিক্ষার্থী সিলেক্ট করুন!');
    return;
  }
  let callHtml = '<div style="display:flex; flex-direction:column; gap:8px;">';
  selected.forEach((s, idx) => {
    callHtml += `
      <div style="display:flex; justify-content:space-between; align-items:center; padding:8px 12px; background:#f8fafc; border-radius:8px; border:1px solid #e2e8f0;">
        <div><strong>${idx+1}. ${s.name}</strong> (Roll: ${s.roll})<div style="font-size:11.5px; color:#64748b;">${s.phone}</div></div>
        <a href="tel:${s.phone}" style="background:#10b981; color:#fff; padding:6px 12px; border-radius:20px; text-decoration:none; font-size:12px; font-weight:600;"><i class="fa-solid fa-phone"></i> Call</a>
      </div>
    `;
  });
  callHtml += '</div>';
  alert('Rapid Call List চালু হয়েছে।');
}

// ==================== ATTENDANCE REPORTS MODULE ====================
let webReportType = 'daily';

function openAttendanceReportModal() {
  setWebReportType('daily');
  openModal('attendanceReportModal');
}

function setWebReportType(type) {
  webReportType = type;
  document.getElementById('repWebTabDaily').className = `seg-btn ${type === 'daily' ? 'active' : ''}`;
  document.getElementById('repWebTabWeekly').className = `seg-btn ${type === 'weekly' ? 'active' : ''}`;
  document.getElementById('repWebTabMonthly').className = `seg-btn ${type === 'monthly' ? 'active' : ''}`;
  renderWebReports();
}

function renderWebReports() {
  const container = document.getElementById('webReportsCardsContainer');
  if (!container) return;
  container.innerHTML = '';

  let list = state.students || [];
  if (list.length === 0) {
    list = [
      { id: 'std-101', name: 'Ahnaf', rollNumber: '01', className: 'Seven', section: 'A', studentPhone: '01710689846' },
      { id: 'std-102', name: 'Asif Fuad', rollNumber: '04', className: 'Seven', section: 'A', studentPhone: '01756346890' }
    ];
  }

  list.forEach((s, idx) => {
    const rollStr = String(s.rollNumber || (idx + 1)).padStart(2, '0');
    const phoneStr = s.studentPhone || s.fatherPhone || '01710689846';
    const dayRecord = webDailyAttendance[webHajiraDate] || {};
    const st = dayRecord[s.id] || (idx === 1 ? 'Absent' : 'Present');

    let pCount = (st === 'Present') ? 1 : 0;
    let aCount = (st === 'Absent') ? 1 : 0;
    let lCount = (st === 'Late') ? 1 : 0;
    let lvCount = (st === 'Leave') ? 1 : 0;
    let total = 1;

    if (webReportType !== 'daily') {
      const dates = Object.keys(webDailyAttendance);
      if (dates.length > 0) {
        total = 0; pCount = 0; aCount = 0; lCount = 0; lvCount = 0;
        dates.forEach(d => {
          const rec = webDailyAttendance[d];
          if (rec && rec[s.id]) {
            total++;
            if (rec[s.id] === 'Present') pCount++;
            else if (rec[s.id] === 'Absent') aCount++;
            else if (rec[s.id] === 'Late') lCount++;
            else if (rec[s.id] === 'Leave') lvCount++;
          }
        });
      }
      if (total === 0) { total = 1; pCount = 1; }
    }

    const pct = Math.round((pCount / total) * 100);

    let msg = '';
    if (webReportType === 'daily') {
      const stText = (st === 'Present') ? 'উপস্থিত (Present)' : (st === 'Late' ? 'দেরিতে (Late)' : (st === 'Leave' ? 'ছুটি (Leave)' : 'অনুপস্থিত (Absent)'));
      msg = `শ্রদ্ধেয় অভিভাবক, আপনার সন্তান ${s.name} (রোল: ${rollStr}, শ্রেণি: ${s.className || 'Seven'}) আজকের (${webHajiraDate}) হাজিরায়: ${stText}। - ABS Hisab Manager`;
    } else if (webReportType === 'weekly') {
      msg = `শ্রদ্ধেয় অভিভাবক, ${s.name} (রোল: ${rollStr}, শ্রেণি: ${s.className || 'Seven'})-এর সাপ্তাহিক হাজিরা রিপোর্ট: উপস্থিত: ${pCount} দিন, অনুপস্থিত: ${aCount} দিন। উপস্থিতির হার: ${pct}%। - ABS Hisab Manager`;
    } else {
      msg = `শ্রদ্ধেয় অভিভাবক, ${s.name} (রোল: ${rollStr}, শ্রেণি: ${s.className || 'Seven'})-এর মাসিক হাজিরা রিপোর্ট: মোট উপস্থিতি: ${pCount} দিন, অনুপস্থিতি: ${aCount} দিন। উপস্থিতির হার: ${pct}%। - ABS Hisab Manager`;
    }

    let waPhone = phoneStr.replace(/[^0-9]/g, '');
    if (waPhone.startsWith('01')) waPhone = '88' + waPhone;
    const waLink = `https://api.whatsapp.com/send?phone=${waPhone}&text=${encodeURIComponent(msg)}`;
    const smsLink = `sms:${phoneStr}?body=${encodeURIComponent(msg)}`;

    const card = document.createElement('div');
    card.style.cssText = 'background:#fff; border-radius:12px; border:1px solid #e2e8f0; padding:12px;';
    card.innerHTML = `
      <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:8px;">
        <div>
          <strong style="font-size:14px;">${s.name} (Roll ${rollStr})</strong>
          <div style="font-size:11.5px; color:#64748b;">শ্রেণি: ${s.className || 'Seven'} • সেকশন: ${s.section || 'A'}</div>
        </div>
        <span style="font-size:11.5px; font-weight:700; background:#dcfce7; color:#15803d; padding:3px 8px; border-radius:12px;">${pct}% হাজিরা</span>
      </div>
      <div style="background:#f8fafc; border-left:3px solid #1e60db; padding:8px; font-size:11.5px; color:#334155; border-radius:4px; margin-bottom:10px; line-height:1.4;">
        <strong>বার্তা:</strong> ${msg}
      </div>
      <div style="display:flex; gap:6px; flex-wrap:wrap;">
        <a href="${waLink}" target="_blank" style="background:#22c55e; color:#fff; padding:6px 10px; border-radius:6px; font-size:11px; font-weight:600; text-decoration:none; display:inline-flex; align-items:center; gap:4px;">
          <i class="fa-brands fa-whatsapp"></i> WhatsApp পাঠান
        </a>
        <a href="${smsLink}" style="background:#2563eb; color:#fff; padding:6px 10px; border-radius:6px; font-size:11px; font-weight:600; text-decoration:none; display:inline-flex; align-items:center; gap:4px;">
          <i class="fa-solid fa-comment-sms"></i> SMS পাঠান
        </a>
        <button type="button" onclick="navigator.clipboard.writeText('${msg.replace(/'/g, "\\'")}').then(()=>alert('কপি হয়েছে!'))" style="background:#f1f5f9; color:#334155; border:1px solid #cbd5e1; padding:6px 10px; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;">
          <i class="fa-solid fa-copy"></i> কপি
        </button>
      </div>
    `;
    container.appendChild(card);
  });
}

